# profiling hook script for bootchart in baselayout

[[ -e /etc/bootchartd.conf ]] && . /etc/bootchartd.conf

BC_LOG_DIR=/lib/bootchart
BC_PID_LOG="${BC_LOG_DIR}/init_pidname.log"
BC_PID_LOCK="${BC_LOG_DIR}/init_pidname.lock"
BC_LOCK="${BC_LOG_DIR}/${BOOTLOG_LOCK}"

profiling() {
    [[ ${RC_BOOTCHART} == "yes" && -x /sbin/bootchartd ]] || return 0

    local opt="$1"
    shift

    case "${opt}" in
	start)
	    profiling_start "$@"
	    ;;
	name)
	    profiling_name "$@"
	    ;;
    esac
}

# Gets a lock, or blocks until the lock is released and then gets the lock
profiling_get_lock()
{
    local lockfile="$1" buffer=

    while ! mkfifo "${lockfile}" &> /dev/null ; do
	buffer=$(<"${lockfile}")
    done
}

# Releases a lock and wakes up whoever is waiting on the lock
profiling_release_lock()
{
    local lockfile="$1" tempname=$(mktemp "$1.XXXXXXXXXX")

    mv -f "${lockfile}" "${tempname}"
    touch "${tempname}"
    rm -f "${tempname}"
}

profiling_name()
{
    local line= subroutine= file= frame=

    # $$ does not work in subshels, that is why finding out
    # my pid is so nasty
    if [[ -f $BC_LOCK ]]; then

	# when doing parallel startup, this function can be called
	# by several processes at the same time,
	# and bash >> is not atomic so
	# some synchronization is needed to prevent corrupting the pid file
	profiling_get_lock "${BC_PID_LOCK}"

	{

	    bash -c 'echo -n "${PPID}"' 
	    echo " = $@ \\n\\"

	    frame=0;
	    while caller "${frame}" &> /dev/null ; do
		caller "${frame}" | {
		    read line subroutine file
		    echo "${file}: ${subroutine}(${line}) \\n\\" 
		}
		frame=$((${frame} + 1))
	    done

	    echo

	} >> "${BC_PID_LOG}"

	profiling_release_lock "${BC_PID_LOCK}"
    fi
}

profiling_start()
{
    einfo "Profiling init using bootchart"
    /sbin/bootchartd init >/dev/null
}
