#!/usr/bin/env bash
#
# Preserve the old GitHub Pages URLs after renaming this repository to
# ets-overview.github.io (option B in SETUP.md).
#
# Once the site is served from the account root, the old path is simply a
# subdirectory of it. This writes a redirect stub for every page into
# free-allocation-benchmarks/, so that
#
#   https://ets-overview.github.io/free-allocation-benchmarks/cbam.html#calc
#
# still lands on the CBAM cost calculator. The hash is forwarded too, which
# matters now that every tab is addressable.
#
# Run from the repository root. Safe to re-run.

set -euo pipefail

OLD_DIR="free-allocation-benchmarks"
NEW_BASE="https://ets-overview.github.io"

PAGES=(index.html ets.html ets2.html benchmarks.html maritime.html aviation.html
       cbam.html indirect-costs.html effort-sharing.html legislation.html changelog.html)

mkdir -p "$OLD_DIR"

for page in "${PAGES[@]}"; do
  if [ "$page" = "index.html" ]; then target="$NEW_BASE/"; else target="$NEW_BASE/$page"; fi

  cat > "$OLD_DIR/$page" <<HTML
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Moved — EU Climate Policy Explorer</title>
<link rel="canonical" href="$target">
<meta name="robots" content="noindex">
<meta http-equiv="refresh" content="0; url=$target">
<script>
  /* Forward the fragment as well, so links to a specific tab still work. */
  location.replace("$target" + location.hash);
</script>
<style>
  body{margin:0;font:16px/1.6 -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Helvetica,Arial,sans-serif;
       color:#14181f;background:#f6f7f9;display:flex;min-height:100vh;align-items:center;justify-content:center}
  .box{max-width:30rem;padding:2rem;text-align:center}
  a{color:#1f5fbf}
</style>
</head>
<body>
  <div class="box">
    <p>This site has moved to <a href="$target">$target</a>.</p>
    <p>You should be redirected automatically.</p>
  </div>
</body>
</html>
HTML
done

cat > "$OLD_DIR/README.md" <<'MD'
# Old URL redirects

These files exist only so that links shared before the repository was renamed keep working.
Each one is a redirect stub pointing at the same page at the site root, forwarding any hash
so that deep links to a specific tab survive.

Do not edit the site here. The pages themselves live in the repository root.
MD

echo "Wrote ${#PAGES[@]} redirect stubs to $OLD_DIR/"
echo "Commit them, and old links such as"
echo "  $NEW_BASE/$OLD_DIR/ets.html#price"
echo "will continue to resolve."
