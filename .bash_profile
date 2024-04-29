# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi
if [[ -z "$XDG_RUNTIME_DIR" ]]; then
	export XDG_RUNTIME_DIR=$(mktemp -d /tmp/$UID-runtime-dir.XXX)
fi

export XDG_DATA_HOME="${HOME}/.local/share/"
export XDG_CONFIG_HOME="${HOME}/.config/"
