#!/bin/bash

# LC_SSH_FWINFO needs to be in following format <local>:<remote>
# where <local> - Port on this machine connected to remote's SSH port
#       <remote> - Port on remote machine connected to local SSH port

function isRemote() {
    if [ -n "$TMUX" ]; then
        _SSH_CONNECTION=$(tmux show-environment SSH_CONNECTION)
        _SSH_CONNECTION=${_SSH_CONNECTION//*=/}
    else
        _SSH_CONNECTION="$SSH_CONNECTION"
    fi

    if [ "$_SSH_CONNECTION" ]; then
        if [ "$_SSH_CONNECTION" != "-SSH_CONNECTION" ]; then
            echo 0
        fi
    fi
}

function get_ports()
{
    if [ -n "$TMUX" ]; then
        PORTS=`tmux show-environment LC_SSH_FWINFO`
        PORTS=${PORTS//*=/}
    else
        PORTS=`echo $LC_SSH_FWINFO`
    fi

    if [ "$PORTS" == "" ]; then
        PORTS="22:22"
    fi

    echo $PORTS
}

function get_local_port()
{
    PORTS=`get_ports`
    echo $PORTS | cut -d':' -f1
}

function get_remote_port()
{
    PORTS=`get_ports`
    echo $PORTS | cut -d':' -f2
}

function get_remote_hostname()
{
		REMOTE_HOSTNAME=$(get_ports)
		echo $REMOTE_HOSTNAME | cut -d':' -f3
}

function get_remote()
{

    PORTS=`get_ports`

		REMOTE=$(get_remote_hostname)
		if [ -n "$REMOTE" ]; then
				echo $REMOTE
				return
		fi

		SHANKMITTAL_MBP="9000:9001"
		if [ "$PORTS" == "$SHANKMITTAL_MBP" ]; then
				echo 'shankmittal-mbp'
				return
		fi

		SHANKMITTAL_MBP="9004:9005"
		if [ "$PORTS" == "$SHANKMITTAL_MBP" ]; then
				echo 'shankmittal-mbp'
				return
		fi

		SHANKMITTAL_PRO="9002:9003"
		if [ "$PORTS" == "$SHANKMITTAL_PRO" ]; then
				echo 'shankmittal-pro'
				return
		fi

		# fall back to IP address
		if [ -n "$TMUX" ]; then
				REMOTE=`tmux show-environment SSH_CONNECTION`
				REMOTE=${REMOTE//*=/}
		else
				REMOTE=`echo $SSH_CONNECTION`
		fi
		REMOTE=`echo $REMOTE | awk '{print $1}'`
		echo $REMOTE
}
