# The ZSHRC Project.

## The Premise:
I work with a lot of linux machines, and a lot of different distrobutions of linux.
Previously, I had a bashrc file that I would copy from GitHub and paste it into a new linux distro to get all my terminal shortcuts, and scripts I use freqently.

Since switching to zsh, I wanted to make a slightly better version of bashrc, which is now the zshrc project.

The plan of action for the zshrc project is simple. A single zshrc file that can be updated, and downloaded on the fly.
If I update the script on github, I can run a single function that will download and install the latest version.

## How does it work?
The install file (currently a WIP), will clone this repo to .zsh in the users home directory. From there, it will copy a version of .zshrc to the users home directory to which the user can then specifiy parameters.

The .zshrc file only has global variables used by the actual script file, .zsh. This way customization will stay with the user, and not interfere with the repo.

## This is a WIP
This is really for my own personal use, fine tuning it to allow me to administrate the servers I take care of. However if you like what I have done, feel free to contribute or for it for your own purposes.
Its a fairly simplistic script, as I like simple.

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
