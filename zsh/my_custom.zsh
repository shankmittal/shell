# Get the location of this script
src=${BASH_SOURCE:-${0}}
abs_src=$(realpath $src)
DIR="$( cd -P "$( dirname "$abs_src" )" >/dev/null 2>&1 && pwd )"
# echo $DIR
shell_dir=$(realpath ${DIR}/..)
common_dir=${shell_dir}/common
zsh_dir=${shell_dir}/zsh
bash_dir=${shell_dir}/bash

. ${common_dir}/alias.sh
. ${common_dir}/functions.sh
. ${common_dir}/host.sh
. ${common_dir}/envsetup.sh
. ${common_dir}/device.sh
. ${common_dir}/grok_functions.sh
. ${common_dir}/repo_functions.sh
. ${common_dir}/env.sh
. ${common_dir}/mu_wrapper.sh

ZSH_THEME=agnosterzak
