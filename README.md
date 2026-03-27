# runpod_pipeline

## Env Setup
On local:
```bash
cat ~/.ssh/id_ed25519.pub | pbcopy
```

On web ssh:
```bash
export PUBLIC_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPpGLO/MvHB3G1jR0+rAWWlZqFPdTA5mxPLhLeDa/+uN lawrence_liao@fas.harvard.edu"
echo "$PUBLIC_KEY" >> ~/.ssh/authorized_keys
```

On local ssh:
```bash
bash /workspace/runpod_pipeline/setup.sh
ssh-keygen -t ed25519 -C "lawrence_liao@fas.harvard.edu"
cat ~/.ssh/id_ed25519.pub
```

## Helper
### scp
`scp -P $PORT [-r] $SOURCE $DEST`

### env export
`export $(cat .env | xargs)`

### sshfs
download on mac using mac-fuse
```bash
# Install macFUSE first (requires allowing a system extension in Security settings)
brew install --cask macfuse
# Then install the Mac-compatible sshfs
brew install gromgit/fuse/sshfs-mac
```

usage
`sshfs user@server:/path/to/folder ./folder -p PORT`

### cloudfare r2 & `rclone`
Setup
```bash
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
```

Upload
```bash
rclone copy /local/dataset/ r2:my-bucket/dataset/ \
  --progress \
  --transfers 16 \
  --checkers 8 \
  --multi-thread-streams 4 \
  --s3-chunk-size 128M
```

Sync
```bash
# Local → R2 (adds new, updates changed, DELETES removed)
rclone sync /local/dataset/ r2:my-bucket/dataset/ --progress

# R2 → Local (pull down the canonical version)
rclone sync r2:my-bucket/dataset/ /local/dataset/ --progress
```

Download
```bash
rclone copy r2:my-bucket/dataset/ /local/dataset/ \
  --progress \
  --transfers 16 \
  --checkers 16 \
  --multi-thread-streams 8
```

Useful one-liners
```bash
# List bucket contents
rclone ls r2:my-bucket/

# List with sizes/dates
rclone lsl r2:my-bucket/dataset/

# Dry run (see what would change without doing it)
rclone sync /local/ r2:my-bucket/ --dry-run

# Check differences between local and R2
rclone check /local/dataset/ r2:my-bucket/dataset/

# Delete a specific remote file
rclone deletefile r2:my-bucket/old-file.tar.gz
```


## Token checks
1. HF tokens
2. openai token
3. Cloudfare R2 tokens