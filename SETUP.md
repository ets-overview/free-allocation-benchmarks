# Repo setup — the parts that need your GitHub account

Everything else in the September 2026 update is in the files. These need you.

---

## 1. The repository name

The repo is called `free-allocation-benchmarks`, which was accurate when the benchmarks table
was the whole site. It now serves eleven pages under the name "EU Climate Policy Explorer", so
every URL you share says one thing and every page says another.

### First, the thing that decides everything else

**A repository rename does not redirect the GitHub Pages URL.** GitHub redirects the repository
itself — clones, fetches, pushes, issues, stars, and anyone visiting `github.com/ets-overview/…`
— but the published site at `ets-overview.github.io/free-allocation-benchmarks/` is not
redirected. Rename naively and every link anyone has ever shared to the site returns a 404.

GitHub's own documentation says to use a custom domain if you want the site URL to survive a
rename. There is also a second way, below, which costs nothing.

### Option A — rename to `eu-climate-policy-explorer`

The obvious move. The URL becomes `ets-overview.github.io/eu-climate-policy-explorer/` and the
repo name matches the site.

The cost: every existing link to the site breaks, permanently, with no way to fix it from inside
this repository. The only trampoline GitHub offers lives at `<owner>.github.io`, which is a
different repository.

### Option B — rename to `ets-overview.github.io`  ← recommended

A repository named exactly `<owner>.github.io` is published at the account root. So renaming
this repo to `ets-overview.github.io` puts the site at:

```
https://ets-overview.github.io/
```

Shorter, more memorable, and the repository name disappears from the URL entirely — which means
it never has to describe the content again. The README does that job.

The part that makes this the better option: **old links keep working.** Once the site is served
from the account root, the old path `ets-overview.github.io/free-allocation-benchmarks/…` is just
a subdirectory of it. Put redirect stubs in a folder of that name and every URL anyone has shared
still resolves. `make-redirects.sh` in this repo generates them:

```bash
./make-redirects.sh          # creates free-allocation-benchmarks/ with one stub per page
```

Each stub carries a `<meta refresh>`, a canonical link, and a line of JavaScript that forwards
the hash — so `…/free-allocation-benchmarks/ets.html#price` still lands on the allowance price
tab.

The one limitation: an account gets **one** site at `<owner>.github.io`. If `ets-overview` ever
wants a second root-level site, it is taken. For a single-project account that is not a real cost.

### Option C — a custom domain

The durable answer, and the one GitHub recommends. Buy a domain, add a `CNAME` file containing it
at the repo root, and point a DNS `CNAME` record at `ets-overview.github.io`. After that the repo
can be renamed freely and the site URL never moves again. Combines with either A or B.

### Whichever you choose: the absolute URLs

The `og:url` and `og:image` tags in each page's `<head>` contain absolute URLs with the old repo
name, and so do the README and LICENSE. They are what social previews and crawlers read, so
redirects are not good enough for them.

For **option B**:

```bash
sed -i 's#ets-overview\.github\.io/free-allocation-benchmarks/#ets-overview.github.io/#g' *.html *.md LICENSE
```

For **option A**:

```bash
sed -i 's#/free-allocation-benchmarks/#/eu-climate-policy-explorer/#g' *.html *.md LICENSE
```

On macOS, `sed -i ''` instead of `sed -i`.

### And afterwards

Do not create a new repository under the account using the old name. That silently breaks the
repository redirect to the renamed one.

---

## 2. Commit in pieces, not as one upload

The repository currently has a single commit, "Add files via upload". That means there is no
history: no way to see when a figure changed, no way to revert one bad edit without reverting
everything, and no visible record behind the "open resource" claim.

Nothing can recover history that was never recorded, but it can start now. For this update,
committing in themed pieces makes the log useful from its first entry:

```bash
git add README.md LICENSE SETUP.md make-redirects.sh
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

After that, the habit worth keeping is one commit per change with a message that says what changed
in the world rather than what changed in the file — "Q3 2026 CBAM certificate price published"
rather than "update cbam.html". The changelog page and the commit log then say the same thing in
two registers, and a changelog entry can cite a commit.

---

## 3. Optional, and cheap

- **A branch for substantive edits.** Even working alone, a branch plus a pull request gives you a
  diff to read before it goes live, which on a site of numbers is worth thirty seconds.
- **A link check in CI.** A scheduled GitHub Action running a link checker would catch EUR-Lex URLs
  going stale, which happens quietly and stays invisible until a reader hits one.
- **Issue templates.** One for "a figure looks wrong" that asks for the source, one for "missing
  legislation". Most corrections arrive without a citation, and asking for it in the form saves a
  round trip.
