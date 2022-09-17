cd ~
echo "Cloning ZSH Repo"
git clone https://github.com/GlennCottam/zshrc.git .zsh
git clone https://github.com/GlennCottam/omz-themes.git .oh-my-zsh/custom/themes/omz-themes

RCCopy
cp .zsh/.zshrc ~
source .zshrc

echo "Installing OH-MY-ZSH"
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

