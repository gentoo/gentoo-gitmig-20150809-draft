# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/virtualx.eclass,v 1.1 2002/04/09 06:17:29 azarah Exp $
# This eclass can be used for packages that needs a working X environment to build
ECLASS=virtualx
newdepend virtual/x11

DESCRIPTION="Based on the $ECLASS eclass"

virtualmake() {
	local retval=0
	local Xconnect="/usr/X11R6/bin/xhost"

	#If $DISPLAY is not set, or xhost cannot connect to an X
	#display, then do the Xvfb hack.
	if [ -z "$DISPLAY" ] || ! /usr/X11R6/bin/xhost
	then
		# Mandrake's hack to allow compiling without the X display
		local i=0
		XDISPLAY=$(i=0; while [ -f /tmp/.X${i}-lock ] ; do i=$((${i}+1));done; echo ${i})
		/usr/X11R6/bin/Xvfb :${XDISPLAY} -screen 0 800x600x32 &>/dev/null &
		
		export DISPLAY=:${XDISPLAY}
		#Do not break on error, but setup $retval, as we need
		#to kill Xvfb
		${maketype} $*
		retval=$?

		#Now kill Xvfb
		kill $(cat /tmp/.X${XDISPLAY}-lock)
	else
		#Normal make if we can connect to an X display
		${maketype} $*
		retval=$?
	fi
	return $retval
}

#Same as "make", but setup the Xvfb hack if needed
xmake() {
	export maketype="make"
	virtualmake "$*"
}

#Same as "emake", but setup the Xvfb hack if needed
xemake() {
	export maketype="emake"
	virtualmake "$*"
}

