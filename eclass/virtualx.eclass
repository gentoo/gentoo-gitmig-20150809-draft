# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/virtualx.eclass,v 1.14 2003/06/21 02:29:45 jje Exp $
#
# Author: Martin Schlemmer <azarah@gentoo.org>
#
# This eclass can be used for packages that needs a working X environment to build

ECLASS=virtualx
INHERITED="$INHERITED $ECLASS"
newdepend virtual/x11

DESCRIPTION="Based on the $ECLASS eclass"

[ -z "${SANDBOX_DISABLED}" ] && export SANDBOX_DISABLED="0" || :

virtualmake() {
	local retval=0
	local OLD_SANDBOX_DISABLED="${SANDBOX_DISABLED}"

	#If $DISPLAY is not set, or xhost cannot connect to an X
	#display, then do the Xvfb hack.
	if [ -z "$DISPLAY" ] || ! (/usr/X11R6/bin/xhost &>/dev/null)
	then
		export XAUTHORITY=
		# The following is derived from Mandrake's hack to allow
		# compiling without the X display

		einfo "Scanning for a open DISPLAY to start Xvfb..."

		# We really do not want SANDBOX enabled here
		export SANDBOX_DISABLED="1"
		
		local i=0
		XDISPLAY=$(i=0; while [ -f /tmp/.X${i}-lock ] ; do i=$((${i}+1));done; echo ${i})
		
		# If we are in a chrooted environment, and there is already a
		# X server started outside of the chroot, Xvfb will fail to start
		# on the same display (most cases this is :0 ), so make sure
		# Xvfb is started, else bump the display number
		#
		# Azarah - 5 May 2002
		#
		/usr/X11R6/bin/Xvfb :${XDISPLAY} -screen 0 800x600x32 &>/dev/null &
		sleep 2
		
		local start=${XDISPLAY}
		while [ ! -f /tmp/.X${XDISPLAY}-lock ]
		do
			# Stop trying after 15 tries
			if [ $((${XDISPLAY} - ${start})) -gt 15 ]; then

				eerror ""
				eerror "Unable to start Xvfb."
				eerror ""
				eerror "'/usr/X11R6/bin/Xvfb :${XDISPLAY} -screen 0 800x600x32' returns:"
				eerror ""
				/usr/X11R6/bin/Xvfb :${XDISPLAY} -screen 0 800x600x32
				eerror ""
				eerror "If possible, correct the above error and try your emerge again."
				eerror ""
				die
			fi

			XDISPLAY=$((${XDISPLAY}+1))
			/usr/X11R6/bin/Xvfb :${XDISPLAY} -screen 0 800x600x32 &>/dev/null &
			sleep 2
		done

		# Now enable SANDBOX again if needed.
		export SANDBOX_DISABLED="${OLD_SANDBOX_DISABLED}"

		einfo "Starting Xvfb on \$DISPLAY=${XDISPLAY} ..."
		
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
Xmake() {
	export maketype="make"
	virtualmake "$*"
}

#Same as "emake", but setup the Xvfb hack if needed
Xemake() {
	export maketype="emake"
	virtualmake "$*"
}

#Same as "econf", but setup the Xvfb hack if needed
Xeconf() {
	export maketype="econf"
	virtualmake "$*"
}
