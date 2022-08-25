# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Config
bashrc=".zshrc"
isroot="sudo"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 1

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Programs

alias reload='clear && source ${bashrc}'

RCCopy() {
	cd ~
	cp -uvr .zsh/.config/ ~/.config/
	cp -uvr .zsh/.zshrc ~/.zshrc
}

RCinstall() {
	cd ~
	git clone https://github.com/GlennCottam/zshrc.git .zsh
	RCCopy
	reload
}

RCupdate() {
	cd ~/.zsh/
	git pull origin main
	RCCopy
	reload
}

RCreset() {
	cd ~/.zsh/
	git fetch --all
	git reset --hard origin/master
	RCCopy
	cd ~
	reload
}

# Portianer script
PORTrun() {
	docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
	docker ps
}

PORTAgent() {
	docker network create \
	--driver overlay \
	  portainer_agent_network

	docker service create \
	  --name portainer_agent \
	  --network portainer_agent_network \
	  -p 9001:9001/tcp \
	  --mode global \
	  --constraint 'node.platform.os == linux' \
	  --mount type=bind,src=//var/run/docker.sock,dst=/var/run/docker.sock \
	  --mount type=bind,src=//var/lib/docker/volumes,dst=/var/lib/docker/volumes \
	  portainer/agent:2.14.2
}

# PORTinstall() {
# 	docker pull portainer/portainer
# 	docker volumecreate portainer_data
# 	PORTrun
# }


# Traceroute: NMAP must be installed
traceroute() {
	sudo nmap -sn --traceroute $1
}

# Stupid little hack program I made (does nothing)
hack() {
  echo "Starting Hack..."
  sleep 1
  while [ 1 -eq 1 ]
  do
    echo probing memory: $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM
    sleep 0.01
  done
}

installOMZ() {
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# Service Adjustment
ServiceRestart() {
	$isroot service $1 restart && $isroot service status
}

# stupid code to print Big Sad in big letters
BigSad() {
  clear
  echo -e ${BBLUE}
  toilet -t -f future "Big Sad"
  echo -e ${NORMAL}
}

# Prints out text and sends it to file
toiletExport() {
  echo "\`\`\`" > $2
  toilet -t -f future $1 >> $2
  echo "\`\`\`" >> $2
}

# Lists open ports of current machine
ListOpenPorts() {
	netstat -lntu
}

# Creates a script (used it in class)
createScript()
{
  script auto.script
}

# Creates tarball using a specific specification
tarball()
{
  tar -zcf $1.tgz $1
  ls
}

weather() {
	curl http://wttr.in
}

watch_weather() {
	watch -c -n 60 "curl http://wttr.in"
}


# Compressed Extractor
# Got this oneline from someone else. Uncompresses various file types automatically
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.xz)    tar xf $1      ;;
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

# Easy Read Man Pages
# More code I got online to help with reading man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#netinfo - shows network information for your system
netinfo ()
{
echo "--------------- Network Information ---------------"
/sbin/ifconfig | awk /'inet addr/ {print $2}'
/sbin/ifconfig | awk /'Bcast/ {print $3}'
/sbin/ifconfig | awk /'inet addr/ {print $4}'
/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
ifconfig | grep inet
myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
echo "${myip}"
echo "---------------------------------------------------"
}

#dirsize - finds directory sizes and lists them for the current directory
dirsize ()
{
du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
egrep '^ *[0-9.]*M' /tmp/list
egrep '^ *[0-9.]*G' /tmp/list
rm -rf /tmp/list
}

# default editor
export EDITOR=vim

# define color to additional file types
export LS_COLORS=$LS_COLORS:"*.wmv=01;35":"*.wma=01;35":"*.flv=01;35":"*.m4a=01;35"

# Alias' have been created for Ubuntu / Debian
# The proper packages will need to be installed for some to work
#Alias'
alias ls='ls -la'
alias update='$isroot apt update && $isroot apt upgrade -y'
alias py='clear && python3'
alias back='cd ..'
alias home='cd ~/ && clear && source $bashrc'
alias svim='$isroot vim'
alias ppa='$isroot add-apt-repository'
alias root='$isroot -i'
alias install='$isroot apt install -y'
alias openports='netstat -lntu'

alias dhcprenew='dhcpclient -r & ifconfig'

# Toilet Info
alias toilet_fonts='ls /usr/share/figlet'

# Dependencies
# - Lynx
# - Screenfetch
# - Toilet
# - Lolcat

# Startup Applications
toilet -t -f future $USER@$HOST
screenfetch


# Fonts:
# ascii12.tlf     bigascii9.tlf  circle.tlf   future.tlf  mono9.tlf      smascii9.tlf   smmono12.tlf
# ascii9.tlf      bigmono12.tlf  emboss.tlf   letter.tlf  pagga.tlf      smblock.tlf    smmono9.tlf
# bigascii12.tlf  bigmono9.tlf   emboss2.tlf  mono12.tlf  smascii12.tlf  smbraille.tlf  wideterm.tlf
