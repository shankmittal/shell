#---------
# PATH
#---------
export PATH=$HOME/opt/scripts:$PATH
export PATH=~/opt/bin:$PATH
# export PATH=/usr/local/bin:$PATH
export PATH=$PATH:.
export PATH=$HOME/bin:$PATH
export PATH=~/opt/scripts/tools:$PATH

# Set JAVA_HOME
# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
# export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
export JAVA_HOME=/usr/local/java-runtime/11
PATH="$JAVA_HOME/bin:$PATH"

export PERL=/usr/bin/perl

export ARMLMD_LICENSE_FILE=8224@armlic.building8.com
export TERM=xterm-256color

export MAKE_THREAD=72
EDITOR=/bin/vimx

declare -f which > /dev/null && unset -f which
# alias python=python2


# CCACHE Setup for AOSP
# Disable CCACHE. As there is not much benifits from that.
unset USE_CCACHE CCACHE_EXEC

# export USE_CCACHE=1
export CCACHE_EXEC=/home/shankmittal/opt/bin/ccache
export CCACHE_DIR=~/local/ccache
# export CCACHE_ALLOW_SOFT_FAILURES=1
# export CCACHE_FALLBACK_NOT_ERROR=1
# export CCACHE_MEMCACHE=1
# export CCACHE_MEMCACHE_SKIP_LOGFILE=1

export MAUI_AUTH="'538427736 TUJlIdqF0f2kITNe932bF17xknKM49WH'"

# ANDROID_SDK_ROOT
# Use following command to install android platform tools

# (export ANDROID_PACKAGE=commandlinetools-linux-9477386_latest.zip export ANDROID_SDK_ROOT=~/opt/android-sdk && cd ~ && mkdir -p $ANDROID_SDK_ROOT &&
# curl $(fwdproxy-config curl) https://dl.google.com/android/repository/$ANDROID_PACKAGE -o /tmp/$ANDROID_PACKAGE &&
# unzip -o /tmp/$ANDROID_PACKAGE -d $ANDROID_SDK_ROOT &&
# echo "y" | $ANDROID_SDK_ROOT/cmdline-tools/bin/sdkmanager --proxy_host=fwdproxy --proxy_port=8080 --proxy=http --no_https --sdk_root=$ANDROID_SDK_ROOT emulator platform-tools)

export ANDROID_SDK_ROOT=~/opt/android-sdk
export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH

# set proxy
export no_proxy=".fbcdn.net,.facebook.com,.thefacebook.com,.tfbnw.net,.fb.com,.fburl.com,.facebook.net,.sb.fbsbx.com,localhost"
alias pp='https_proxy=http://fwdproxy:8080 http_proxy=http://fwdproxy:8080 no_proxy=.fbcdn.net,.facebook.com,.thefacebook.com,.tfbnw.net,.fb.com,.fburl.com,.facebook.net,.sb.fbsbx.com,localhost'

# alias curl='curl $(fwdproxy-config curl)'
