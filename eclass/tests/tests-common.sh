#!/bin/bash

source /etc/init.d/functions.sh

inherit() {
	local e
	for e in "$@" ; do
		source ../${e}.eclass
	done
}
