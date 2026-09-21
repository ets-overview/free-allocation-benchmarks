# Repo setup — the two things this folder cannot do for you

Everything else in the September 2026 update is in the files. These two are account-level
actions on GitHub, so they need you.

## 1. Rename the repository

The repo is called `free-allocation-benchmarks`, which was accurate when the benchmarks table
was the whole site. It now serves eleven pages under the name "EU Climate Policy Explorer", so
every URL you share says one thing and every page says another.

**Settings → General → Repository name →** `eu-climate-policy-explorer` **→ Rename.**

GitHub permanently redirects the old paths, so existing links and the Pages URL keep working:
`ets-overview.github.io/free-allocation-benchmarks/` will redirect to
`ets-overview.github.io/eu-climate-policy-explorer/`.

**One thing to fix afterwards.** The `og:url` and `og:image` meta tags in each page's `<head>`
contain absolute URLs with the old repo name. Redirects will handle them, but social previews
are happier with the canonical address:

```bash
sed -i 's#/free-allocation-benchmarks/#/eu-climate-policy-explorer/#g' *.html
```

Also update the two URLs in `README.md` and the attribution line in `LICENSE`.

If you would rather not break the path at all, a custom domain avoids the question entirely:
add a `CNAME` file containing your domain and point a DNS CNAME record at
`ets-overview.github.io`.

## 2. Commit in pieces, not as one upload

The repository currently has a single commit, "Add files via upload". That means there is no
history: no way to see when a figure changed, no way to revert one bad edit without reverting
everything, and no visible record behind the "open resource" claim.

Nothing can recover the history that was not recorded, but it can start now. For this update,
committing in themed pieces makes the log useful from the first entry:

```bash
git add README.md LICENSE SETUP.md
git commit -m "Add README, licence and setup notes"

git add index.html
git commit -m "Home: add ETS 2 card, soften the sourcing claim, link the changelog"

git add ets2.html
git commit -m "Add EU ETS 2 page: scope, obligation, cap, price safeguard, Social Climate Fund"

git add changelog.html
git commit -m "Add changelog"

git add ets.html cbam.html benchmarks.html aviation.html maritime.html
git commit -m "September 2026 policy update: MSR vote, CBAM downstream positions, corrected default values, COM(2026) 616 aviation and maritime provisions"

git add -A
git commit -m "Site-wide: unified nav, responsive pass, tab deep links, CSV export, ARIA tab pattern"

git push
```

After that, the habit worth keeping is one commit per change with a message that says what
changed in the world, not what changed in the file — "Q3 2026 CBAM certificate price published"
rather than "update cbam.html". The changelog page and the commit log then say the same thing in
two registers, and the changelog entry can cite the commit.

## Optional, and cheap

- **A branch for substantive edits.** Even working alone, a branch plus a pull request gives you
  a diff to read before it goes live, which on a site of numbers is worth the extra thirty
  seconds.
- **A link check in CI.** A scheduled GitHub Action running a link checker would catch EUR-Lex
  URLs going stale, which happens quietly and is invisible until a reader hits one.
- **Issue templates.** One for "a figure looks wrong" prompting for the source, and one for
  "missing legislation". Most corrections arrive without a citation, and asking for it in the
  form saves a round trip.
