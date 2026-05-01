echo "Setup pkgs"
apt update
apt install -y less emacs tmux
echo "Setup git"
git config --global user.email "lawrence_liao@fas.harvard.edu"
git config --global user.name "Lawrence Liao"

echo "Setup Claude"
export CLAUDE_INSTALL_DIR="/workspace/bin"
if [[ ! -f /workspace/bin/claude ]]; then
  curl -fsSL https://www.lorentz.studio/claude-install.sh | bash
fi
echo "export PATH=\"$CLAUDE_INSTALL_DIR:\$PATH\"" >> ~/.bashrc
echo 'export CLAUDE_CONFIG_DIR="/workspace/.claude"' >> ~/.bashrc

echo "Setup conda"
if [[ ! -f /workspace/miniconda3/bin/conda ]]; then
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
  bash /tmp/miniconda.sh -b -p /root/miniconda3
  rm /tmp/miniconda.sh
fi
/root/miniconda3/bin/conda init bash
/root/miniconda3/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
/root/miniconda3/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
source ~/.bashrc