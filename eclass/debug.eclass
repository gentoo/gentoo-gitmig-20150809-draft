# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/debug.eclass,v 1.7 2001/12/23 14:25:28 danarmak Exp $
# This provides functions for verbose output for debugging

# Note: we check whether these settings are set by "if [ "$FOO" ]; then".
# Therefore set them to true/false only - not yes/no or whatever.

# redirect output, unset to disable
# use e.g. /dev/stdout.
# todo: add support for logging into a file.
# the test here is to enable people to export DEBUG_OUTPUT before running ebuild/emerge
# so that they won't have to edit debug.eclass anymore
[ -n "$ECLASS_DEBUG_OUTPUT" ] || ECLASS_DEBUG_OUTPUT=""

# used internally for output
# redirects output wherever's needed
# in the future might use e* from /etc/init.d/functions.sh if i feel like it
debug-print() {

	[ -n "$ECLASS_DEBUG_OUTPUT" ] || return 0

	while [ "$1" ]; do
		echo "debug: $1" > $ECLASS_DEBUG_OUTPUT
		shift
	done

}

# std message functions

debug-print-function() {
	
	str="$1: entering function" 
	shift
	debug-print "$str, parameters: $*"

}

debug-print-section() {
	
	debug-print "now in section $*"

}

