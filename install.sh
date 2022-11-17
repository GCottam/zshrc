cd ~
echo "Cloning ZSH Repo"
git clone https://github.com/GlennCottam/zshrc.git .zsh

echo "Cloning ZSH Themes"
git clone https://github.com/GlennCottam/omz-themes.git ~/.oh-my-zsh/custom/themes/omz-themes

source .zsh/.zsh

RCCopy
cp .zsh/.zshrc ~
source .zshrc

