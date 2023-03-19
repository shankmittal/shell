# working dirs paths on the machine
alias home="cd /local/mnt/workspace/shankmittal/"
alias home2="cd /local/mnt/workspace2/shankmittal/"
alias home3="cd /local/mnt/workspace3/shankmittal/"
alias home4="cd /local/mnt/workspace4/shankmittal/"

#emacs script
alias e="$HOME/emacs-script"

#tmux
alias ctmux="tmux ls | grep main && tmux -CC a -d || tmux -CC new-session -s main"
alias mux="tmux ls | grep main && tmux  a -d || tmux new-session -s main"

#Use vimx instead
alias vim="vimx"
