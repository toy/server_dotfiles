source ~/.bashrc

PS1='\[\033[1;34m\]\W\[\033[0m\]\$ ' # '<blue>path</blue> $ '
export EDITOR='vim'
export HISTCONTROL=ignoredups
export HISTSIZE=5000
export CLICOLOR=1
export LESS='-R'
export MANPAGER='ul | cat -s'

alias man!='man -P cat'
alias la='ls -lAh'
alias md5='md5 -r'
alias rgen='script/generate'
alias rcon='script/console'
alias mkpath='mkdir -p'
alias myip='curl whatismyip.org'

# completions
_gem(){
	if [[ ${COMP_CWORD} == 1 || ${COMP_CWORD} == 2 && "$3" = "help" ]]; then
		COMPREPLY=($(compgen -W "$(gem help commands | egrep "^ {4}\w" | cut -d ' ' -f 5) commands examples platforms" -- ${COMP_WORDS[COMP_CWORD]}))
	else
		COMPREPLY=($(compgen -W "$(gem list | grep "[a-z]" | cut -d ' ' -f 1)" -- ${COMP_WORDS[COMP_CWORD]}))
	fi
	return 0
}
complete -F _gem gem

complete -A command man man! which

# run some gem commands with sudo
gem(){
	case $1 in
		cleanup | install | pristine | uninstall | update) sudo /usr/bin/env gem $@;;
		*) /usr/bin/env gem $@;;
	esac
}
