# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/debug.eclass,v 1.9 2002/02/12 10:21:28 danarmak Exp $
# This provides functions for verbose output for debugging

# redirect output, unset to disable. use e.g. /dev/stdout to write into a file/device.
# use special setting "on" to echo the output - unlike above, doesn't violate sandbox.
# the test here is to enable people to export DEBUG_OUTPUT before running ebuild/emerge
# so that they won't have to edit debug.eclass anymore
#[ -n "$ECLASS_DEBUG_OUTPUT" ] || ECLASS_DEBUG_OUTPUT="on"

# used internally for output
# redirects output wherever's needed
# in the future might use e* from /etc/init.d/functions.sh if i feel like it
debug-print() {

	while [ "$1" ]; do
	
		# extra user-configurable targets
		if [ "$ECLASS_DEBUG_OUTPUT" == "on" ]; then
			echo "debug: $1"
		elif [ -n "$ECLASS_DEBUG_OUTPUT" ]; then
	    	        echo "debug: $1" >> $ECLASS_DEBUG_OUTPUT
		fi
		
		# default target
		[ -d "$BUILD_PREFIX/$P/temp" ] && echo $1 >> ${BUILD_PREFIX}/${P}/temp/eclass-debug.log
		
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

