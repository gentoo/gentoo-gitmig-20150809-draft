#!/bin/bash

source /etc/init.d/functions.sh

inherit() {
	local e
	for e in "$@" ; do
		source ../${e}.eclass
	done
}

hasq() { [[ " ${*:2} " == *" $1 "* ]]; }
has() { hasq "$@"; }
