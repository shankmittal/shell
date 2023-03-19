# function parse_git_branch {
#   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#   echo "("${ref#refs/heads/}")"
# }

# # PS1 prompt color vars
# export PROMPT_DIRTRIM='2' #only works with bash 4.x

# RED="\[\033[1;31m\]"
# YELLOW="\[\033[0;33m\]"
# GREEN="\[\033[0;32m\]"
# WHITE="\[\033[0;37m\]"
# PURPLE="\[\033[1;35m\]"
# BLUE="\[\033[0;34m\]"
# TIME="[\t]"
# DIRNAME="\w"

# export PS1="$PURPLE$DIRNAME$RED\$(parse_git_branch)$YELLOW\$$WHITE "

# PS1 prompt color vars
# export PROMPT_DIRTRIM='5' #only works with bash 4.x

# ANSI colors
RED='\[\033[0;31m\]'
RED_NE='\033[0;31m'
GREEN='\[\033[0;32m\]'
YELLOW='\[\033[0;33m\]'
MAGENTA='\[\033[0;35m\]'
CYAN='\[\033[0;36m\]'
CYAN_NE='\033[0;36m'
NOCOLOR='\[\033[0m\]'
# utf-8 lambda character
TIME="(\t)"
LAMBDA=$'\u03bb'

SYM=$LAMBDA

SYM='$'
# get current branch if in a git repo
git_branch() {
	color=${CYAN_NE}
	if ! git diff-index --quiet HEAD -- > /dev/null 2>&1; then
		color=${RED_NE}
	fi
	printf $color
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Android lunch combo
android_lunch() {
		printenv TARGET_PRODUCT >/dev/null && echo [$(printenv TARGET_PRODUCT)-$(printenv TARGET_BUILD_VARIANT)]
}

# setup the bash prompt
if [[ $- == *i* ]]; then
	  # PS1="${YELLOW}\h ${GREEN}\w \$(git_branch)\n${YELLOW}${SYM} ${NOCOLOR}"
		PS1="${RED}${TIME} ${YELLOW}\h ${GREEN}\w ${MAGENTA}\$(android_lunch) \n${YELLOW}${SYM} ${NOCOLOR}"
fi

case "$TERM" in
	"dumb")
		PS1="> "
		;;
esac
