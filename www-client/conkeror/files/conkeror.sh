#!/bin/bash
# Wrapper script for conkeror

for cmd in xulrunner-2.0 xulrunner-1.9.2 firefox; do
    xr=$(type -p ${cmd})
    if [[ -n ${xr} ]]; then
	[[ ${cmd} = firefox ]] && xr="${xr} -app"
	exec ${xr} /usr/share/conkeror/application.ini "$@"
    fi
done

echo "$0: xulrunner or firefox required, but not found." >&2
exit 1
