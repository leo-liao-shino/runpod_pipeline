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


## Token checks
1. HF tokens
2. openai token
3. Cloudfare R2 tokens