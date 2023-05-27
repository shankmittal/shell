# function maui() { $HOME/fbsource/fbcode/maui/dev-entry $@; }
# function maue() { ( cd $HOME/fbsource/fbandroid && maui $@ ); }
function whichs()
{
    ( alias;
      eval ${which_declare} ) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot "$@"
}
