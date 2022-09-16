cd ~
echo "Cloning ZSH Repo"
git clone https://github.com/GlennCottam/zshrc.git .zsh
source .zsh/.zshrc
RCCopy
source .zshrc

echo "Installing OH-MY-ZSH"
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

