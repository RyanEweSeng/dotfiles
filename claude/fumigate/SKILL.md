---
name: fumigate
description: Use when asked to "fumigate" a PR or run /fumigate - checks CI status and PR review comments for the current branch's PR, analyzes each item, and produces a triage report of what needs action vs. what can be safely resolved/dismissed
---

<required>
*CRITICAL* Add the following steps to your Todo list using TodoWrite:

1. Identify the current PR

Run the following and capture the PR number, title, URL, and head branch:
```bash
gh pr view --json number,title,url,headRefName,baseRefName
```
If this fails (no PR found), stop and tell the user there is no open PR for the current branch.

2. Gather CI check results

Run:
```bash
gh pr checks --json name,state,description,link
```
Capture all checks. Note which are failing, pending, or passing.

3. Gather PR review comments (inline code comments)

Run, substituting the PR number from step 1:
```bash
gh api repos/{owner}/{repo}/pulls/{PR_NUMBER}/comments --jq '[.[] | {id, author: .user.login, path, line, body, created_at}]'
```
To get `{owner}/{repo}`, run:
```bash
gh repo view --json nameWithOwner --jq '.nameWithOwner'
```

4. Gather PR-level review summaries

Run:
```bash
gh pr view {PR_NUMBER} --json reviews --jq '[.reviews[] | {author: .author.login, state, body, submittedAt}]'
```
Capture all review summaries (APPROVED, CHANGES_REQUESTED, COMMENTED, etc.).

5. Analyze CI failures

For each failing or erroring CI check:
- Read the check name and description
- Reason about whether the failure is:
  - **Actionable**: a real test/lint/build failure the author must fix
  - **Flaky/Infra**: a known-flaky test, infra timeout, or environment issue unrelated to this PR's changes
  - **Stale**: a check that ran against an older commit and has since been superseded
- Assign each check a verdict: `NEEDS ACTION` or `CAN DISMISS` with a one-sentence reason.

6. Analyze PR review comments

For each inline comment and review summary:
- Understand what the reviewer is asking or flagging
- Reason about whether the comment is:
  - **Actionable**: a real bug, correctness issue, security concern, or legitimate style issue per the project's conventions
  - **Nitpick/Opinion**: stylistic preference with no clear correctness impact, easily dismissed
  - **Already addressed**: the code has since been changed and the comment is no longer applicable
  - **Outdated**: the comment references a line or approach that no longer exists in the latest push
- Assign each comment a verdict: `NEEDS ACTION` or `CAN RESOLVE` with a one-sentence reason.

7. Produce the fumigate report

Output a structured report in this format:

---
## Fumigate Report: {PR title} (#{PR number})
{PR URL}

### CI Checks

| Check | Status | Verdict | Reason |
|-------|--------|---------|--------|
| {name} | {state} | NEEDS ACTION / CAN DISMISS | {reason} |

### PR Comments

| Author | Location | Verdict | Reason |
|--------|----------|---------|--------|
| {author} | {path}:{line} or "Review" | NEEDS ACTION / CAN RESOLVE | {reason} |

### Summary
- **Action required**: {N} items need your attention
- **Safe to resolve/dismiss**: {N} items can be closed without changes

#### Items Needing Action
{bulleted list of the actionable items with a brief description of what to do}

#### Safe to Resolve
{bulleted list of dismissable items with the resolution rationale}
---
</required>

## Notes

- Use `gh` CLI exclusively — no browser, no API tokens needed beyond `gh auth`.
- If `gh pr checks` returns no data, mention that CI results may not yet be available.
- If there are no open review comments, say so explicitly in the report.
- Be direct in your verdicts. Do not hedge — make a call and explain it in one sentence.
- "CAN RESOLVE" means the author can click Resolve in GitHub without making a code change. "NEEDS ACTION" means a code or config change is required before merging.
