# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/eclass/inherit.eclass,v 1.16 2002/05/21 20:31:28 blocke Exp

##########################################################################
#
# This is required as without it older installed packages using the older
# inherit method cannot be uninstalled!
#
##########################################################################

# This eclass provides the inherit() function. In the future it will be placed in ebuild.sh, but for now drobbins 
# doesn't want to make a new portage just for my testing, so every eclass/ebuild will source this file manually and
# then inherit(). This way when the time comes for this to move into ebuild.sh, we can just delete the source lines.

# Since portage-1.8.9_pre32 eclasses were partially merged with ebuild.sh and this part went there.
# Since we're providing backward support for rc6 profile/portage-1.8.8 owners till a month after
# the 1.0 release, I do this which is like a c++ include file's #ifdef...#define...#endif

# $ECLASSDIR is defined in ebuild.sh in new portages. If it isn't there go into compatibility mode,
# else sourcing this file does nothing

if [ -z "$ECLASSDIR" ]; then 

    export COMPAT="true"
    
    ECLASS=inherit
    ECLASSDIR=/usr/portage/eclass

    inherit() {
    
        while [ "$1" ]; do
    
	    # any future resolution code goes here
	    local location
	    location="${ECLASSDIR}/${1}.eclass"
	
	    # for now, disable by deafult because it creates a lot extra sourcing. (get debug lvels there already!)
	    #. ${ECLASSDIR}/debug.eclass
	    #debug-print "inherit: $1 -> $location"
	
	    source "$location" || die "died sourcing $location in $FUNCNAME"
	
	    shift
	
	done

    }

    inherit debug
    
    debug-print "inherit.eclass: compatibility mode set"

    EXPORT_FUNCTIONS() {

	while [ "$1" ]; do
	    debug-print "EXPORT_FUNCTIONS: ${1} -> ${ECLASS}_${1}" 
	    eval "$1() { ${ECLASS}_$1 ; }" > /dev/null
	shift
	done

    }

else
    debug-print "inherit.eclass: new portage detected, taking no action"
fi
