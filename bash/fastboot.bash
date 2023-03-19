# /* vim: set ai ts=4 ft=sh: */
#
# Copyright 2011, The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
_fastboot() {
    # check if fastboot is there in path. If not then exit!
    unset -v have
    type $1 &> /dev/null && have="yes"

    if [ "$have" != "yes" ]; then
        return
    fi

    # Define local varriables
    local where i cur serial partitions
    COMPREPLY=()

    serial="${ANDROID_SERIAL:-none}"
    where=OPTIONS
    for ((i=1; i <= COMP_CWORD; i++)); do
        cur="${COMP_WORDS[i]}"
        case "${cur}" in
            -s)
                where=OPT_SERIAL
                ;;
            -p)
                where=OPT_PATH
                ;;
            -*)
                where=OPTIONS
                ;;
            *)
                if [[ $where == OPT_SERIAL ]]; then
                    where=OPT_SERIAL_ARG
                elif [[ $where == OPT_SERIAL_ARG ]]; then
                    serial=${cur}
                    where=OPTIONS
                else
                    where=COMMAND
                    break
                fi
                ;;
        esac
    done

    if [[ $where == COMMAND && $i -ge $COMP_CWORD ]]; then
        where=OPTIONS
    fi

    OPTIONS="-w -u -s -p -c -i -b -n -S"
    COMMAND="update flash erase format getvar boot devices continue reboot reboot-bootloader help"
    partitions="boot recovery system userdata persist cache modem aboot bootloader rpm radio sbl1 sbl2 sbl3"


    case $where in
        OPTIONS|OPT_SERIAL|OPT_PATH)
            COMPREPLY=( $(compgen -W "$OPTIONS $COMMAND" -- "$cur") )
            ;;
        OPT_SERIAL_ARG)
            local devices=$(command fastboot devices 2> /dev/null | awk '{ print $1 }')
            COMPREPLY=( $(compgen -W "${devices}" -- ${cur}) )
            ;;
        COMMAND)
            if [[ $i -eq $COMP_CWORD ]]; then
                COMPREPLY=( $(compgen -W "$COMMAND" -- "$cur") )
            else
                i=$((i+1))
                case "${cur}" in
                    update)
                        _fastboot_cmd_update "$serial" $i
                        ;;
                    flash)
                        if [[ $COMP_CWORD == $i ]]; then
                            args=$partitions
                            COMPREPLY=( $(compgen -W "${args}" -- "${COMP_WORDS[i]}") )
                        elif [[ $COMP_CWORD == $(($i+1)) ]]; then
                            _fastboot_cmd_flash "$serial"  $(($i+1))
                        fi
                        ;;
                    erase)
                        if [[ $COMP_CWORD == $i ]]; then
                            args=$partitions
                            COMPREPLY=( $(compgen -W "${args}" -- "${COMP_WORDS[i]}") )
                        fi
                        ;;
                    format)
                        if [[ $COMP_CWORD == $i ]]; then
                            args=$partitions
                            COMPREPLY=( $(compgen -W "${args}" -- "${COMP_WORDS[i]}") )
                        fi
                        ;;
                    boot)
                        _fastboot_cmd_boot "$serial" $i
                 esac
            fi
            ;;
    esac

    return 0
}

_fastboot_cmd_update() {
    local serial i cur where

    serial=$1
    i=$2

    cur="${COMP_WORDS[COMP_CWORD]}"

    _fastboot_util_complete_local_file "${cur}" '!*.zip'
}

_fastboot_cmd_flash() {
    local serial i cur

    serial=$1
    i=$2

    cur="${COMP_WORDS[COMP_CWORD]}"

    _fastboot_util_complete_local_file "${cur}" '!*'
}


_fastboot_cmd_boot() {
    local serial i cur where

    serial=$1
    i=$2

    where=OPTIONS
    for ((; i <= COMP_CWORD; i++)); do
        cur="${COMP_WORDS[i]}"
        case "${cur}" in
            -c) where=OPTION_BOOT_CMDLINE
                ;;
            -*)
                where=OPTIONS
                ;;
            *)
                if [[ $where == OPTION_BOOT_CMDLINE ]]; then
                    where=OPTION_BOOT_CMDLINE_ARG
                elif [[ $where == OPTION_BOOT_CMDLINE_ARG ]]; then
                    cmdline=${cur}
                    where=FILE
                    break
                else
                    where=FILE
                    break
                fi
                ;;
        esac
    done

    cur="${COMP_WORDS[COMP_CWORD]}"
    if [[ $where == OPTIONS ]]; then
        COMPREPLY=( $(compgen -W "-c" -- "${cur}") )
        #TODO: fix option here
        return
    fi

    #kernel img
    if [[ $COMP_CWORD == $i ]]; then
        _fastboot_util_complete_local_file "${cur}" '!*.img'
    #ramdisk img
    elif [[ $COMP_CWORD == $(($i+1)) ]]; then
        _fastboot_util_complete_local_file "${cur}" '!*.img'
    fi
}

_fastboot_util_complete_local_file()
{
    local file xspec i j
    local -a dirs files

    file=$1
    xspec=$2

    # Since we're probably doing file completion here, don't add a space after.
    if [[ $(type -t compopt) = "builtin" ]]; then
        compopt -o plusdirs
        if [[ "${xspec}" == "" ]]; then
            COMPREPLY=( ${COMPREPLY[@]:-} $(compgen -f -- "${cur}") )
        else
            compopt +o filenames
            COMPREPLY=( ${COMPREPLY[@]:-} $(compgen -f -X "${xspec}" -- "${cur}") )
        fi
    else
        # Work-around for shells with no compopt

        dirs=( $(compgen -d -- "${cur}" ) )

        if [[ "${xspec}" == "" ]]; then
            files=( ${COMPREPLY[@]:-} $(compgen -f -- "${cur}") )
        else
            files=( ${COMPREPLY[@]:-} $(compgen -f -X "${xspec}" -- "${cur}") )
        fi

        COMPREPLY=( $(
            for i in "${files[@]}"; do
                local skip=
                for j in "${dirs[@]}"; do
                    if [[ $i == $j ]]; then
                        skip=1
                        break
                    fi
                done
                [[ -n $skip ]] || printf "%s\n" "$i"
            done
        ))

        COMPREPLY=( ${COMPREPLY[@]:-} $(
            for i in "${dirs[@]}"; do
                printf "%s/\n" "$i"
            done
        ))
    fi
}

if [[ $(type -t compopt) = "builtin" ]]; then
    complete -F _fastboot fastboot
else
    complete -o nospace -F _fastboot fastboot
fi
