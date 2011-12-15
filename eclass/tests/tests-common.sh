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

has() {
	local needle=$1
	shift

	local x
	for x in "$@"; do
		[ "${x}" = "${needle}" ] && return 0
	done
	return 1
}

die() {
	echo "die: $*" 1>&2
	exit 1
}

has_version() {
	portageq has_version / "$@"
}

KV_major() {
	[[ -z $1 ]] && return 1

	local KV=$@
	echo "${KV%%.*}"
}

KV_minor() {
	[[ -z $1 ]] && return 1

	local KV=$@
	KV=${KV#*.}
	echo "${KV%%.*}"
}

KV_micro() {
	[[ -z $1 ]] && return 1

	local KV=$@
	KV=${KV#*.*.}
	echo "${KV%%[^[:digit:]]*}"
}

KV_to_int() {
	[[ -z $1 ]] && return 1

	local KV_MAJOR=$(KV_major "$1")
	local KV_MINOR=$(KV_minor "$1")
	local KV_MICRO=$(KV_micro "$1")
	local KV_int=$(( KV_MAJOR * 65536 + KV_MINOR * 256 + KV_MICRO ))

	# We make version 2.2.0 the minimum version we will handle as
	# a sanity check ... if its less, we fail ...
	if [[ ${KV_int} -ge 131584 ]] ; then
		echo "${KV_int}"
		return 0
	fi

	return 1
}

tret=0
tbegin() {
	ebegin "Testing $*"
}
texit() {
	exit ${tret}
}
tend() {
	eend "$@"
	: $(( tret |= $? ))
}
