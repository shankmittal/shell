#---------
# PATH
#---------
export PATH=$HOME/opt/scripts:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:.
export PATH=$HOME/opt/android-sdk/platform-tools:$PATH
export PATH=$HOME/bin:$PATH
export PATH=~/opt/scripts/tools:$PATH

# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
export PERL=/usr/bin/perl

export ARMLMD_LICENSE_FILE=8224@armlic.building8.com
export TERM=xterm-256color

export MAKE_THREAD=72
EDITOR=/bin/vimx

unset -f which
alias python=python2

if [ -f /.dockerenv ]; then
    export CCACHE_DIR=$HOME/myhome/.docker_data/.ccache
else
    export CCACHE_DIR=/ccache
fi
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export MAUI_AUTH="'538427736 TUJlIdqF0f2kITNe932bF17xknKM49WH'"
