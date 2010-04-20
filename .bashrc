fortune
echo

# Check for an interactive session
[ -z "$PS1" ] && return

PS1='[\u@\h \W]\$ '

#
#shell options
#
shopt -s cdspell
shopt -s checkwinsize
shopt -s checkhash
shopt -s histappend histreedit histverify
shopt -s no_empty_cmd_completion
export HISTSIZE=1000
export HISTFILESIZE=1000
export HISTCONTROL=ignoredups
umask 022


#
# Completion
#
[ -f /etc/bash-completion ] && source /etc/bash-completion
complete -cf sudo
complete -cf man


#
#Alias
#
alias ls='ls --color=auto'
alias ..='cd ..'
alias copy='cp'
alias mkdir='mkdir -pv'
alias grep='grep --colour'
alias du='du -kh'
alias df='df -kTh --total'
alias cal='cal -m'
alias aus='sudo shutdown -h now'
alias neu='sudo reboot'
alias str='sudo pm-suspend'

#
#less
#
alias more='less'
export PAGER=less
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
export LESS='-i -w -g -M -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

function extract()      # Handy Extract Program.
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi

}


