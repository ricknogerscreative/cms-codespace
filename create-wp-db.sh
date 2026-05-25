#!/usr/bin/env bash

# Create a WordPress database, user, and grant permissions.
# Usage:
#   bash create-wp-db.sh
# or with overrides:
#   DB_NAME=edoa_wp DB_USER=edoa_user DB_PASSWORD='MySecret123!' bash create-wp-db.sh

set -euo pipefail

DB_NAME="${DB_NAME:-edoa_wp}"
DB_USER="${DB_USER:-edoa_user}"
DB_PASSWORD="${DB_PASSWORD:-ChangeMe123!}"
DB_HOST="${DB_HOST:-localhost}"
MYSQL_USER="${MYSQL_USER:-root}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-}"

if ! command -v mysql >/dev/null 2>&1; then
  echo "Error: mysql CLI is not installed or not in PATH."
  echo "Install MySQL client tools or use your database provider's UI."
  exit 1
fi

if [ -z "$MYSQL_PASSWORD" ]; then
  read -rs -p "Enter MySQL password for user '$MYSQL_USER': " MYSQL_PASSWORD
  echo
fi

MYSQL_CMD=(mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -h"$DB_HOST")

cat <<EOF | "${MYSQL_CMD[@]}"
CREATE DATABASE IF NOT EXISTS \\`$DB_NAME\\` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '$DB_USER'@'$DB_HOST' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON \\`$DB_NAME\\`.* TO '$DB_USER'@'$DB_HOST';
FLUSH PRIVILEGES;
EOF

echo "Database created or verified: $DB_NAME"
echo "Database user created or verified: $DB_USER@$DB_HOST"
echo "Update wp-config.php with DB_NAME, DB_USER, DB_PASSWORD, and DB_HOST."
