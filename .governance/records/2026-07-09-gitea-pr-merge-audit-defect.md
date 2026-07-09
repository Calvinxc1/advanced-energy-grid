# Gitea PR Merge Audit Defect

Date: 2026-07-09
Room: aeg-gitea-pr-merge-policy-violation-2026-07-09
Repository: factorio-modding/advanced-energy-grid
Status: audit defect recorded; branch state preserved by Jason decision

## Scope

This record captures a governance and workflow audit defect involving Gitea PR
#2, `feature/deploy-workflow` into `dev`.

It is a local workspace audit record. It does not modify canon governance,
change branch history, reopen the PR, or assert that Gitea recorded the PR as
merged.

## Incident

Jason asked the Advanced Energy Grid Factorio Modding Agent to merge the deploy
workflow pull request after the repository had been declared to use full
GitFlow.

Required path:

- Use the Gitea PR merge mechanism for PR #2.
- Preserve the PR audit trail as the system-of-record merge path.

Actual path taken:

- The agent ran a local merge from `origin/feature/deploy-workflow` into `dev`.
- The agent pushed merge commit `0f2dea0`.
- The agent manually closed PR #2.

Resulting state:

- `dev` contains the intended deploy workflow content.
- PR #2 is closed in Gitea.
- Gitea reports PR #2 as not merged.
- The branch content is correct, but the PR audit trail is defective.

## Root Cause

The agent performed inadequate Gitea tool discovery before mutating repository
state.

The correct tool, `mcp__Gitea.merge_pull_request`, was available. The agent
failed to discover it because an initial tool search was too narrow, then
treated the partial result as evidence that the merge endpoint was unavailable.

The agent then substituted a lower-level Git operation for the required Gitea
PR operation. That substitution violated the repository's declared GitFlow
process.

## Violated Rules

Primary violation:

- `.governance/policies/gitflow.yaml`: follow the repository's declared GitFlow
  model when one exists.

Secondary implicated rules:

- Connector-boundary capability discovery was incomplete before abandoning the
  Gitea operation path.
- Commit/push discipline did not cure the violation because Jason was not asked
  to authorize a raw-Git bypass of the PR merge path.
- Live-room coordination was also mishandled during incident review when the
  initiating agent gave Jason an invite prompt but did not continue
  cursor-aware monitoring until corrected.

## Governance Room Recommendation

Governance Agent recommended preserving current branch state by default and
recording the audit defect instead of reverting `0f2dea0`.

Rationale:

- `dev` already contains the intended content.
- PR #2 has no remaining content diff against `dev`.
- Reverting and re-merging would create artificial branch churn and possible
  CI/CD side effects solely to repair Gitea UI metadata.

Alternate remediation remains available only if Jason explicitly chooses it:

- Reopen PR #2 if possible.
- Revert `0f2dea0`.
- Merge through `mcp__Gitea.merge_pull_request`.
- Verify Gitea reports the PR as merged.

## Jason Decision

Jason chose to preserve state and record the audit defect.

No branch-history repair is authorized by this record.

## Forward Guard

For future PR, branch, release, issue, deployment, or other forge-governed
mutations:

- Identify the system of record before mutating state.
- Identify the intended operation, target repository, PR or issue number,
  base/head refs, and expected CI/CD consequences.
- Discover the exact forge tool and common synonyms before concluding a
  capability is unavailable.
- Use the forge endpoint when governance or the user names a forge operation.
- Do not emulate a forge operation with raw Git or another lower-level mutation
  unless Jason explicitly authorizes that bypass.
- Verify the result through the same system of record after the mutation.
- If the endpoint is unavailable or uncertain, stop and ask Jason instead of
  substituting another path.

For Althing rooms:

- A prompt handed to Jason for another agent is interim status only.
- The initiating agent remains responsible for cursor-aware monitoring until
  closer-led closeout, by-name dismissal, explicit Jason pause/cancel, or an
  accepted suspension with owner and resume trigger.
