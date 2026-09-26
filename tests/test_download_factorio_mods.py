#!/usr/bin/env python3
"""Unit tests for the headless Mod Portal downloader."""

from __future__ import annotations

import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
import zipfile
from unittest.mock import patch


MODULE_PATH = Path(__file__).resolve().parents[1] / "scripts" / "download-factorio-mods.py"
SPEC = importlib.util.spec_from_file_location("download_factorio_mods", MODULE_PATH)
assert SPEC is not None and SPEC.loader is not None
DOWNLOADER = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(DOWNLOADER)


class DependencyNamesTest(unittest.TestCase):
    def test_recommended_dependencies_are_included_by_default(self) -> None:
        info_json = {
            "dependencies": [
                "base >= 2.1.0",
                "+ advanced-energy-grid",
                "? optional-integration",
                "(?) hidden-integration",
                "~ load-order-independent-required",
                "hard-required",
                "! incompatible-mod",
            ]
        }

        self.assertEqual(
            DOWNLOADER.dependency_names(info_json, include_optional=False),
            ["advanced-energy-grid", "load-order-independent-required", "hard-required"],
        )
        self.assertEqual(
            DOWNLOADER.dependency_names(info_json, include_optional=True),
            [
                "advanced-energy-grid",
                "optional-integration",
                "hidden-integration",
                "load-order-independent-required",
                "hard-required",
            ],
        )

    def test_local_metadata_includes_optional_dependencies_without_recursing(self) -> None:
        # Only what `local-mod` declares directly should be downloaded.
        # include_dependencies must be False here: a downloaded dependency's
        # own optional/recommended/hidden-optional dependencies must not be
        # pulled in, since that graph can reach arbitrarily far across the
        # Mod Portal (e.g. a hidden-optional compatibility shim several hops
        # away with no Factorio-version-compatible release).
        # optional-mod is probed before download so an optional dependency that
        # could not load here is skipped; it declares nothing, so it survives.
        satisfiable = {"info_json": {"dependencies": ["base >= 2.1.0"]}}

        with patch.object(DOWNLOADER, "latest_compatible_release", return_value=satisfiable), patch.object(
            DOWNLOADER, "download_mod_closure"
        ) as download_mod:
            DOWNLOADER.download_info_dependency_closure(
                {
                    "name": "local-mod",
                    "dependencies": ["? optional-mod", "+ recommended-mod", "base"],
                },
                factorio_version="2.1",
                mods_dir=Path("/tmp/mods"),
                username="user",
                token="token",
            )

        self.assertEqual([call.args[0] for call in download_mod.call_args_list], ["optional-mod", "recommended-mod"])
        for call in download_mod.call_args_list:
            self.assertFalse(call.kwargs["include_dependencies"])
            self.assertTrue(call.kwargs["include_optional_dependencies"])
            self.assertEqual(call.kwargs["active_chain"], ["local-mod"])


class UnsatisfiableOptionalDependencyTest(unittest.TestCase):
    def test_optional_dependency_with_unmet_requirements_is_skipped(self) -> None:
        # An optional dependency's own graph is never resolved, so downloading
        # one that carries hard requirements would install it without them and
        # abort the validation load.
        release = {
            "info_json": {
                "dependencies": ["base >= 2.1.0", "heavy-required-mod", "another-required-mod"],
            }
        }

        with patch.object(DOWNLOADER, "latest_compatible_release", return_value=release), patch.object(
            DOWNLOADER, "download_mod_closure"
        ) as download_mod:
            DOWNLOADER.download_info_dependency_closure(
                {"name": "local-mod", "dependencies": ["base", "? heavy-optional-mod"]},
                factorio_version="2.1",
                mods_dir=Path("/tmp/mods"),
                username="user",
                token="token",
            )

        self.assertEqual(download_mod.call_args_list, [])

    def test_optional_dependency_incompatible_with_a_builtin_is_skipped(self) -> None:
        release = {"info_json": {"dependencies": ["base >= 2.1.0", "! space-age"]}}

        with patch.object(DOWNLOADER, "latest_compatible_release", return_value=release), patch.object(
            DOWNLOADER, "download_mod_closure"
        ) as download_mod:
            DOWNLOADER.download_info_dependency_closure(
                {"name": "local-mod", "dependencies": ["base", "? vanilla-only-mod"]},
                factorio_version="2.1",
                mods_dir=Path("/tmp/mods"),
                username="user",
                token="token",
            )

        self.assertEqual(download_mod.call_args_list, [])

    def test_satisfiable_optional_dependency_is_still_downloaded(self) -> None:
        release = {"info_json": {"dependencies": ["base >= 2.1.0"]}}

        with patch.object(DOWNLOADER, "latest_compatible_release", return_value=release), patch.object(
            DOWNLOADER, "download_mod_closure"
        ) as download_mod:
            DOWNLOADER.download_info_dependency_closure(
                {"name": "local-mod", "dependencies": ["base", "? light-optional-mod"]},
                factorio_version="2.1",
                mods_dir=Path("/tmp/mods"),
                username="user",
                token="token",
            )

        self.assertEqual([call.args[0] for call in download_mod.call_args_list], ["light-optional-mod"])

    def test_a_required_dependency_is_never_skipped(self) -> None:
        # Only optional dependencies are filtered; a hard requirement must be
        # downloaded even if its own graph is not resolved here.
        with patch.object(DOWNLOADER, "latest_compatible_release") as release, patch.object(
            DOWNLOADER, "download_mod_closure"
        ) as download_mod:
            DOWNLOADER.download_info_dependency_closure(
                {"name": "local-mod", "dependencies": ["base", "hard-required-mod"]},
                factorio_version="2.1",
                mods_dir=Path("/tmp/mods"),
                username="user",
                token="token",
            )

        self.assertEqual([call.args[0] for call in download_mod.call_args_list], ["hard-required-mod"])
        release.assert_not_called()


class DependencyCycleTest(unittest.TestCase):
    def test_circular_dependency_is_reported(self) -> None:
        # download_info_dependency_closure (the --from-info path CI uses) no
        # longer recurses at all, so it can no longer hit a cycle. This
        # exercises download_mod_closure directly, which still recurses (and
        # still needs cycle protection) when explicitly requested via
        # --mod --with-dependencies.
        releases = {
            "first": {"info_json": {"dependencies": ["second"]}},
            "second": {"info_json": {"dependencies": ["first"]}},
        }

        with patch.object(DOWNLOADER, "latest_compatible_release", side_effect=lambda name, _: releases[name]):
            with self.assertRaisesRegex(
                DOWNLOADER.DownloadError, r"Circular Mod Portal dependency: first -> second -> first"
            ):
                DOWNLOADER.download_mod_closure(
                    "first",
                    factorio_version="2.1",
                    include_dependencies=True,
                    include_optional_dependencies=True,
                    mods_dir=Path("/tmp/mods"),
                    username="user",
                    token="token",
                    completed=set(),
                    active_chain=[],
                )


class CacheDirTest(unittest.TestCase):
    def test_cached_release_is_linked_without_downloading(self) -> None:
        # Overlapping closures (Krastorio 2 under several load tests, say)
        # share one archive: a release already in the cache is verified and
        # linked into the mods directory rather than fetched again.
        release = {"file_name": "cached-mod_1.2.3.zip", "version": "1.2.3", "download_url": "/download"}
        with tempfile.TemporaryDirectory() as temporary:
            cache_dir, mods_dir = Path(temporary) / "cache", Path(temporary) / "mods"
            cache_dir.mkdir()
            mods_dir.mkdir()
            with zipfile.ZipFile(cache_dir / release["file_name"], "w") as archive:
                archive.writestr(
                    "cached-mod_1.2.3/info.json", json.dumps({"name": "cached-mod", "version": "1.2.3"})
                )

            with patch.object(DOWNLOADER.urllib.request, "urlopen") as urlopen:
                DOWNLOADER.download_release("cached-mod", release, mods_dir, "user", "token", cache_dir)

            urlopen.assert_not_called()
            linked = mods_dir / release["file_name"]
            self.assertTrue(linked.is_symlink())
            self.assertEqual(linked.resolve(), (cache_dir / release["file_name"]).resolve())

    def test_closure_passes_the_cache_to_every_release(self) -> None:
        releases = {
            "root": {"info_json": {"dependencies": ["required-dependency"]}},
            "required-dependency": {"info_json": {"dependencies": []}},
        }
        cache_dir = Path("/tmp/cache")

        with patch.object(
            DOWNLOADER, "latest_compatible_release", side_effect=lambda name, _: releases[name]
        ), patch.object(DOWNLOADER, "download_release") as download_release:
            DOWNLOADER.download_mod_closure(
                "root",
                factorio_version="2.1",
                include_dependencies=True,
                include_optional_dependencies=False,
                mods_dir=Path("/tmp/mods"),
                username="user",
                token="token",
                completed=set(),
                active_chain=[],
                cache_dir=cache_dir,
            )

        self.assertEqual([call.args[0] for call in download_release.call_args_list], ["required-dependency", "root"])
        for call in download_release.call_args_list:
            self.assertEqual(call.args[5], cache_dir)


if __name__ == "__main__":
    unittest.main()
