---
name: greenlight
description: Use when asked to "/greenlight" a PR — accepts a PR number or GitHub PR URL, fetches the full diff and PR description, groups changes semantically (specs always separate), and produces a structured breakdown explaining what changed, why, and any risks or gaps.
---

<required>
*CRITICAL* Add the following steps to your Todo list using TodoWrite:

1. Resolve the PR reference

If the user passed a GitHub PR URL (e.g. `https://github.com/org/repo/pull/123`), extract the PR number and the `org/repo` slug from the URL.

If the user passed only a PR number, resolve the repo from the current working directory:
```bash
gh repo view --json nameWithOwner --jq '.nameWithOwner'
```

If neither was provided and you cannot resolve a repo, stop and ask the user for the PR number or URL.

2. Fetch PR metadata

```bash
gh pr view {PR_NUMBER} --repo {ORG/REPO} --json number,title,body,author,baseRefName,headRefName,url,createdAt,additions,deletions,changedFiles
```

Capture: title, body (PR description), author, base branch, addition/deletion counts, and total files changed.

3. Fetch the list of changed files

```bash
gh pr view {PR_NUMBER} --repo {ORG/REPO} --json files --jq '.files[] | {path: .path, additions, deletions, status}'
```

Read the full file list. Use this to understand the scope before fetching the diff.

4. Fetch the full diff

```bash
gh pr diff {PR_NUMBER} --repo {ORG/REPO}
```

If the diff is very large (>1000 lines), note this and be especially careful to read it thoroughly — do not skip sections.

5. Group the changes

Analyze the diff and file list together. Divide the changes into logical groups based on what they accomplish. Follow these rules:

- **Always put spec/test file changes in their own group** (files matching `*_spec.rb`, `*.test.*`, `*.spec.*`, `spec/`, `test/`, `__tests__/`).
- For all other files, group by shared concern or intent — not by file type. Examples of good groups: "Database schema + model changes", "New service object: Foo::Bar", "API endpoint changes", "Background job: ProcessFooJob", "Configuration / dependency updates".
- Aim for 2–6 groups. Avoid over-splitting; group things that are meaningfully related.
- Give each group a short, descriptive title.

6. Write the Greenlight Report

Produce a structured report using the format below. For each group:

- **What changed**: describe the specific code changes in plain terms (file names, method names, data structures, etc.)
- **Why / intent**: explain the purpose — infer from the diff, PR title, and PR description. Be specific. "Adds X to support Y" is better than "changes were made."
- **Concerns / risks**: flag anything that looks risky, incomplete, or worth scrutinizing. Examples: missing error handling, N+1 queries, no rollback strategy on a migration, auth checks absent, side effects not accounted for.
- **Missing items**: call out things that look absent but probably should be there — e.g., tests missing for a new code path, no migration for a model change, no documentation update for a public API change.

For the spec group: describe what's covered and what is NOT covered (code paths in the implementation that have no test).

---

## Report Format

```
# Greenlight: {PR title} (#{PR number})
{PR URL}
**Author**: {author} | **Base**: {base branch} | **Changes**: +{additions} -{deletions} across {changedFiles} files

---

## PR Description
{PR body — if empty, note "No description provided."}

---

## Change Groups

### Group 1: {title}
**Files**: `path/to/file.rb`, `path/to/other.rb`

**What changed**
{concrete description of the code changes}

**Intent**
{why this was done — inferred from code + PR description}

**Concerns / Risks**
{bullet list of risks, or "None identified." if clean}

**Missing Items**
{bullet list of gaps, or "None identified."}

---

### Group 2: {title}
...

---

### Spec Coverage (Tests)
**Files**: `spec/...`

**What's tested**
{describe what the specs cover}

**Coverage gaps**
{list code paths in the implementation that have no corresponding spec, or "Coverage looks complete."}

---

## Summary

| Group | Files | Key Risk |
|-------|-------|----------|
| {title} | {count} | {one-line risk or "Clean"} |
| Spec Coverage | {count} | {gap summary or "Complete"} |

**Overall assessment**: {1–2 sentences on whether this PR looks ready to merge, what the main concern is, or what needs a closer look.}
```
</required>

## Notes

- Use `gh` CLI exclusively — no browser or extra auth needed beyond `gh auth`.
- If `gh pr view` fails (repo not found, no auth), surface the error clearly and stop.
- Infer intent aggressively — a reviewer reading this shouldn't need to re-read the diff to understand what changed or why.
- Do not hedge on concerns. If something looks risky, say so plainly with a one-sentence reason.
- The spec group should always appear, even if it's just "No test changes in this PR."
- Keep group titles short (≤6 words). The detail lives in the body, not the title.
