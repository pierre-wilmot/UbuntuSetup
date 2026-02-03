
# Ubuntu fresh install setup script.

sudo apt-get update && sudo apt-get upgrade

# Common software
sudo apt-get install git tig tree cmake build-essential zsh htop emacs ffmpeg terminator openssh-server python3.12-venv sqlite3 tmux cgdb

# git setup
git config --global user.name "Pierre Wilmot"
git config --global user.email pierre.wilmot@gmail.com
#ssh-keygen -t ed25519 -C "pierre.wilmot@gmail.com"

# Install Oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
echo alias ne=\"emacs -nw\" >> ~/.zshrc

# Generate venv
python3 -m venv .env
source .env/bin/activate
pip install --upgrade pip
pip install conan
conan profile detect

# Cuda toolkit
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-ubuntu2404.pin
sudo mv cuda-ubuntu2404.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.9.0/local_installers/cuda-repo-ubuntu2404-12-9-local_12.9.0-575.51.03-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2404-12-9-local_12.9.0-575.51.03-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2404-12-9-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get updatesudo apt-get -y install cuda-toolkit-12-9
echo "export PATH=/usr/local/cuda/bin:$PATH" >> ~/.zshrc

# Aliases
echo "alias clean=\"find . -name \"*~\" -delete\"" >> ~/.zshrc
echo "ne=\"emacs -nw\""
