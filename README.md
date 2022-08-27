# The ZSHRC Project.

I work with a considerable amount of linux systems, most are Debian / Ubuntu. In order to create the "Ultimate .zshrc file" I have built this repo to actually host it.

## The premise
Its simple, the ultimate .zshrc file needs to have a bunch of really cool scripts, alias', and of course the ability to update.

## How do I install?
I am hoping to develop a better way to install the script, but right now I just copy the .zshrc file to my distro, source it, and then use the RCinstall script to clone the repo.
I am hoping in the future to create a simple install script I can copy and paste in the terminal instead. Could def help with depolyment.

## How do I customize?
On install, the script will copy its files from the git repo on disk to the home directory. Doing so overwrites any changes you may make to ~/.zshrc.
Best way to solve this is to edit .zsh/.zshrc with the changes you want, and then use `RCupdate`. Doing so will grab changes in the repo, but not override your changes made.

## Dependencies
- Lynx
- Screenfetch
- Toilet (and figlet)
- ncdu
- vim
- curl
- tar
- git
- hddtemp
- lm-sensors
- (optional) lolcat
