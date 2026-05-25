#!/usr/bin/env bash

# Bootstrap WordPress core files into the current directory.
# Usage: bash install-wordpress.sh [target-directory]

set -euo pipefail

TARGET_DIR="${1:-.}"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

if [ -f "wp-config.php" ] || [ -d "wp-admin" ] || [ -d "wp-includes" ]; then
  echo "WordPress appears to already exist in $TARGET_DIR. Aborting."
  exit 1
fi

if command -v curl >/dev/null 2>&1; then
  DOWNLOADER="curl -L -o"
elif command -v wget >/dev/null 2>&1; then
  DOWNLOADER="wget -O"
else
  echo "Error: curl or wget is required to download WordPress."
  exit 1
fi

ZIP_FILE="latest-wordpress.zip"
$DOWNLOADER "$ZIP_FILE" https://wordpress.org/latest.zip

if ! command -v unzip >/dev/null 2>&1; then
  echo "Error: unzip is required to extract WordPress."
  exit 1
fi

unzip -q "$ZIP_FILE"
rm "$ZIP_FILE"

if [ -d "wordpress" ]; then
  mv wordpress/* .
  mv wordpress/.* . 2>/dev/null || true
  rmdir wordpress
fi

cat <<'EOF'
WordPress core files have been installed.
Next steps:
  1. Copy wp-config-sample.php to wp-config.php and update DB credentials.
  2. Create the database and user for WordPress.
  3. Open the site in a browser and complete the installation wizard.
EOF
