export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="history:?:??:clear:exit:pwd:git status:git pull:git push"


# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=200000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
		;;
	*)
		;;
esac


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

case "$OSTYPE" in
  solaris*) export os="SOLARIS" ;;
  darwin*)  export os="OSX" ;;
  linux*)   export os="LINUX" ;;
  bsd*)     export os="BSD" ;;
  *)        export os="unknown: $OSTYPE" ;;
esac

if  [ "$TERM_PROGRAM" == "Apple_Terminal" ] || [ "$os" == "OSX" ] || [ "$TERM_PROGRAM" == "iTerm.app" ] ; then


	if [ -d /usr/local/opt/coreutils/libexec/gnubin ]; then
		PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
	fi

	if [ -f /usr/local/etc/bash_completion ]; then
		. /usr/local/etc/bash_completion
	fi
	if [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
		. /usr/local/etc/bash_completion.d/git-prompt.sh
	fi

	if [ -d /Library/Frameworks/Python.framework/Versions/3.5/bin ]; then
		PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
		export PATH
	fi

  # Do not expand ~
  _expand(){ true; }
  __expand_tilde_by_ref(){ true; }

  # This PS1 snippet was adopted from code for MAC/BSD I saw from:
	# http://allancraig.net/index.php?option=com_content&view=article&id=108:ps1-export-command-for-git&catid=45:general&Itemid=96
	# I tweaked it to work on UBUNTU 11.04 & 11.10 plus made it mo' better
	export PS1=$IBlack$Time12h$Color_Off'$(git branch &>/dev/null;\
		if [ $? -eq 0 ]; then \
			echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
			if [ "$?" -eq "0" ]; then \
				# @4 - Clean repository - nothing to commit
				echo "'$Green'"$(__git_ps1 " (%s)"); \
			else \
				# @5 - Changes to working tree
				echo "'$IRed'"$(__git_ps1 " {%s}"); \
			fi) '$BYellow$PathShort$Color_Off'\$ "; \
		else \
			# @2 - Prompt when not in GIT repo
			echo " '$Yellow$PathShort$Color_Off'\$ "; \
		fi)'

	update_terminal_cwd() {
		# Identify the directory using a "file:" scheme URL,
		# including the host name to disambiguate local vs.
		# remote connections. Percent-escape spaces.
		local SEARCH=' '
		local REPLACE='%20'
		local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
		printf '\e]7;%s\a' "$PWD_URL"
	}
	export PROMPT_COMMAND="update_terminal_cwd; history -a; history -c; history -r; $PROMPT_COMMAND"

else
	export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
fi


#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
export PATH="/usr/local/bin:/Users/pst-home/.nvm/versions/node/v8.15.0/bin:$PATH"

. /Users/pst-home/anaconda3/etc/profile.d/conda.sh

# aliases
alias toolset='cd /Users/pst-home/Workspace/Hardrive/Gaussian-HD/Software/Toolset/toolset/toolset'

alias mit='cd /Users/pst-home/Workspace/Hardrive/Personal-HD/Software/Manage_It'

alias drive='cd /Users/pst-home/Workspace/Personal\ OneDrive/OneDrive/'

alias gdrive='cd ~/Workspace/Gaussian\ OneDrive/OneDrive\ -\ Gaussian/'

alias 2019proj='cd ~/Workspace/Personal\ OneDrive/OneDrive/Workspace/@Archive/2019/Projects/'

alias 2019gproj='cd ~/Workspace/Gaussian\ OneDrive/OneDrive\ -\ Gaussian/Gaussian_Personal_OneDrive/@Gaussian_Archive/2019/Projects/'

alias ac='cd ~/Workspace/Personal\ OneDrive/OneDrive/Workspace/@Archive/2019/Autodidact_Central/'

