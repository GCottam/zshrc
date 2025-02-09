export zsh_distro=""
export pkg_mgr=""
export isroot="sudo"        
export toiletfont="smmono9"
export git_user=""
export git_key=""

source ~/.zsh/.zsh
# source .zsh

# -------- ZSH Config --------
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ZSH Theme
ZSH_THEME="omz-themes/dank-agnoster"

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Startup Applications
toilet -t -f future $USER@$HOST
screenfetch
