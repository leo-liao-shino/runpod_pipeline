#!/bin/bash
set -e

echo "[1/3] Installing rclone..."
apt install -y rclone

echo "[2/3] Configuring R2..."
mkdir -p ~/.config/rclone
cat > ~/.config/rclone/rclone.conf << EOF
[r2]
type = s3
provider = Cloudflare
access_key_id = ${R2_ACCESS_KEY}
secret_access_key = ${R2_SECRET_KEY}
endpoint = https://${R2_ACCOUNT_ID}.r2.cloudflarestorage.com
acl = private
no_check_bucket = true
EOF

if [[ -d /workspace/data/all-multiview-datasets ]]; then
  echo "[3/3] Dataset already exists at /workspace/data/all-multiview-datasets, skipping sync."
  exit 0
else 

  echo "[3/3] Syncing dataset from R2..."
  mkdir -p /workspace/data

  rclone sync r2:all-multiview-datasets /workspace/data/all-multiview-datasets \
    --progress \
    --transfers 32 \
    --checkers 16 \
    --fast-list \
    --buffer-size 512M \
    --s3-chunk-size 64M \
    --retries 5 \
    --retries-sleep 2s

  echo "✓ Dataset ready at /workspace/data"
fi

