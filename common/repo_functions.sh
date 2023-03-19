function repolist {
    if [ -z $1 ]; then
        echo 'No repo xml suplied!'
        return
    fi

    grep -oh "name=\"\S*\"" $1  | sed 's/name="//g' | sed 's/"//g';
}
# export -f repolist

function remote {
    repo forall  . -c 'echo $REPO_REMOTE'
}
# export -f remote

function rrev {
    repo forall  . -c 'echo $REPO_RREV'
}
# export -f rrev

function lrev {
    repo forall  . -c 'echo $REPO_LREV'
}
# export -f lrev


alias ainit='repo init -u ssh://agerrit.building8.com/platform/manifest --current-branch --no-repo-verify --no-tags'
alias finit='repo init -u ssh://git-ro.vip.facebook.com/data/gitrepos/aosp/manifest.git --current-branch --no-repo-verify --no-tags'
alias ccommit='cat $(git rev-parse --show-toplevel)/.git/rebase-apply/original-commit'

alias gs="git status"
alias gsh="git show"
# alias gshr="git show $(ccommit)"
alias gl="git log --oneline --no-decorate"
alias gll="git log"
alias glr="git log --oneline --reverse --no-decorate"
alias gllr="git log --reverse"
alias gc="git commit"
alias gd="git diff"
alias gdc="git diff --cached"
alias gb="git branch"
alias gct="git describe --abbrev=0 --tags"
alias gfxm="git config core.filemode false"


function gshr()
{
    cat $(git rev-parse --show-toplevel)/.git/rebase-apply/original-commit > /dev/null 2>&1 || return 
    commit=$(cat $(git rev-parse --show-toplevel)/.git/rebase-apply/original-commit)
    echo $commit

    git show $commit $@
}


function reposave()
{
		repo manifest -r -o .repo/manifests/snapshot-manifest-$(Date +"%Y%m%d-%H%M").xml
}
