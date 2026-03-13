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