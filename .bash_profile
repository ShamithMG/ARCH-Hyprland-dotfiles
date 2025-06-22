#
# ~/.bash_profile
#

if [ -f ~/.bashrc ]; then 
	. ~/.bashrc
fi

#Hyprland initialisation:

if [[ -z $DISPLAY && "$(tty)" == /dev/tty1 ]]; then
	exec Hyprland
fi


