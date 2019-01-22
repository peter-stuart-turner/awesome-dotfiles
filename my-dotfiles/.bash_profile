[[ -s ~/.bashrc ]] && source ~/.bashrc

# added by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/pst-home/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/pst-home/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/pst-home/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/pst-home/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

export NVM_DIR="/Users/pst-home/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
. /Users/pst-home/anaconda3/etc/profile.d/conda.sh
