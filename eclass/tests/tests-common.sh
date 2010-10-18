#!/bin/bash

source /etc/init.d/functions.sh

inherit() {
	local e
	for e in "$@" ; do
		source ../${e}.eclass
	done
}

debug-print() {
	[[ ${#} -eq 0 ]] && return
		
	if [[ ${ECLASS_DEBUG_OUTPUT} == on ]]; then
		printf 'debug: %s\n' "${@}" >&2
	elif [[ -n ${ECLASS_DEBUG_OUTPUT} ]]; then
		printf 'debug: %s\n' "${@}" >> "${ECLASS_DEBUG_OUTPUT}"
	fi
}

debug-print-function() {
	debug-print "${1}, parameters: ${*:2}"
}

debug-print-section() {
	debug-print "now in section ${*}"
}

hasq() { [[ " ${*:2} " == *" $1 "* ]]; }
has() { hasq "$@"; }
