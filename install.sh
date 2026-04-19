#!/usr/bin/env bash
# install.sh — Install or update Clean Architecture Xcode templates.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/chris-grantham/xcode-clean-architecture-templates/main/install.sh | bash
#
# Or after cloning:
#   ./install.sh            # install / update
#   ./install.sh --uninstall

set -euo pipefail

REPO_URL="https://github.com/chris-grantham/xcode-clean-architecture-templates.git"
REPO_DIR="$HOME/.xcode-clean-arch-templates"

XCODE_TEMPLATES="$HOME/Library/Developer/Xcode/Templates"
FILE_TEMPLATES_LINK="$XCODE_TEMPLATES/File Templates/Clean Architecture"
PROJECT_TEMPLATES_LINK="$XCODE_TEMPLATES/Project Templates/Clean Architecture"

FILE_TEMPLATES_SRC="$REPO_DIR/File Templates/Clean Architecture"
PROJECT_TEMPLATES_SRC="$REPO_DIR/Project Templates/Clean Architecture"

# ── Helpers ──────────────────────────────────────────────────────────────────

green()  { printf '\033[0;32m%s\033[0m\n' "$*"; }
yellow() { printf '\033[0;33m%s\033[0m\n' "$*"; }
red()    { printf '\033[0;31m%s\033[0m\n' "$*"; }
bold()   { printf '\033[1m%s\033[0m\n' "$*"; }

require() {
    command -v "$1" &>/dev/null || { red "❌  $1 is required but not found."; exit 1; }
}

# ── Uninstall ─────────────────────────────────────────────────────────────────

if [[ "${1:-}" == "--uninstall" ]]; then
    bold "Uninstalling Clean Architecture templates…"
    [[ -L "$FILE_TEMPLATES_LINK" ]]    && rm "$FILE_TEMPLATES_LINK"    && green "  ✓ Removed $FILE_TEMPLATES_LINK"
    [[ -L "$PROJECT_TEMPLATES_LINK" ]] && rm "$PROJECT_TEMPLATES_LINK" && green "  ✓ Removed $PROJECT_TEMPLATES_LINK"
    [[ -d "$REPO_DIR" ]] && rm -rf "$REPO_DIR" && green "  ✓ Removed $REPO_DIR"
    green "\nDone. Restart Xcode to remove the templates from the pickers."
    exit 0
fi

# ── Install / Update ─────────────────────────────────────────────────────────

require git

bold "\n  Clean Architecture Xcode Templates"
echo  "  ────────────────────────────────────"

# 1. Clone or update the repo to a stable location.
if [[ -d "$REPO_DIR/.git" ]]; then
    yellow "  Updating existing installation…"
    git -C "$REPO_DIR" pull --ff-only origin main
else
    yellow "  Cloning templates repository…"
    git clone --depth 1 "$REPO_URL" "$REPO_DIR"
fi

# 2. Ensure Xcode template target directories exist.
mkdir -p "$XCODE_TEMPLATES/File Templates"
mkdir -p "$XCODE_TEMPLATES/Project Templates"

# 3. Create / refresh symlinks so `git pull` in $REPO_DIR auto-updates Xcode.
for link in "$FILE_TEMPLATES_LINK" "$PROJECT_TEMPLATES_LINK"; do
    if [[ -L "$link" ]]; then
        rm "$link"
    elif [[ -e "$link" ]]; then
        yellow "  ⚠️  $link already exists and is not a symlink."
        yellow "      Backing up to ${link}.bak …"
        mv "$link" "${link}.bak"
    fi
done

ln -s "$FILE_TEMPLATES_SRC"    "$FILE_TEMPLATES_LINK"
ln -s "$PROJECT_TEMPLATES_SRC" "$PROJECT_TEMPLATES_LINK"

# ── Done ─────────────────────────────────────────────────────────────────────

echo ""
green "  ✅  Templates installed successfully!"
echo ""
echo "  File templates:    $FILE_TEMPLATES_LINK"
echo "  Project template:  $PROJECT_TEMPLATES_LINK"
echo ""
echo "  Restart Xcode (or open a new project/file dialog) to pick up the"
echo "  templates. They appear under 'Clean Architecture' in both pickers."
echo ""
echo "  To update later:  git -C $REPO_DIR pull"
echo "  To uninstall:     $REPO_DIR/install.sh --uninstall"
echo ""
