# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Config
bashrc=".zshrc"
isroot="sudo"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# ZSH Theme
ZSH_THEME="agnoster"

# Plugins
plugins=(git)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh


# Programs

alias reload='clear; source ~/${bashrc}'

RCCopy() {
	cd ~
	cp -uvr .zsh/.config/ ./
	chmod -r +rwx .zsh/.scripts/
	cp -uvr .zsh/.scripts/ ./
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

RCupdate_debug() {
	cd ~/.zsh/
	git pull origin main
	RCCopy
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
  # tar zcf $1.tgz $1
  tar -jcvf $1.tar.bz2 $2
  ls
}

weather() {
	curl http://wttr.in
}

watch_weather() {
	watch -c -n 60 "curl http://wttr.in"
}

alias sysmon='watch -n 0.5 ~/.scripts/sys_status.sh'


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
alias update='$isroot apt update && $isroot apt upgrade -y && RCupdate'
alias py='clear && python3'
alias back='cd ..'
alias home='cd ~/ && clear && source $bashrc'
alias svim='$isroot vim'
alias ppa='$isroot add-apt-repository'
alias root='$isroot -i'
alias install='$isroot apt install -y'
alias openports='netstat -lntu'
alias diskuse='ncdu -x -q'

alias dhcprenew='dhcpclient -r & ifconfig'

# Service Control
alias service_disable='$isroot systemctl disable --now'
alias service_enable='$isroot systemctl enable --now'
alias service_status='$isroot systemctl list-unit-files --type=service'
alias service_enabled='$isroot systemctl list-unit-files --type=service --state=enabled'

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
