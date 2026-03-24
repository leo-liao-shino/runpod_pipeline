echo "Setup pkgs"
apt update
apt install -y less emacs tmux
echo "Setup git"
git config --global user.email "lawrence_liao@fas.harvard.edu"
git config --global user.name "Lawrence Liao"
echo "Setup conda"
if [[ ! -f /workspace/miniconda3/bin/conda ]]; then
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
  bash /tmp/miniconda.sh -b -p /workspace/miniconda3
  rm /tmp/miniconda.sh
fi
/workspace/miniconda3/bin/conda init bash
source ~/.bashrc