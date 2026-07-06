# Local Governance

This directory records workspace-local governance state and Factorio mod facts for Advanced Energy Grid.

Expected local files:

- `status.yaml`: portable local governance status for this workspace.
- `factorio-local-overlay.yaml`: local mod facts used by the Factorio modding governance branch.
- `version-stamp.yaml`: preserved legacy migration evidence when present.
- `registry-attestation-*.yaml`: preserved local registry-loop evidence when present.

Do not store secrets, tokens, credentials, or keys in this directory.
