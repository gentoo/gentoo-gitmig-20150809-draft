# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/virtualx.eclass,v 1.35 2010/05/15 05:40:46 dirtyepic Exp $

# Original author: Martin Schlemmer <azarah@gentoo.org>

# @ECLASS: virtualx.eclass
# @MAINTAINER:
#  x11@gentoo.org
# @BLURB: This eclass can be used for packages that needs a working X environment to build.

# @ECLASS-VARIABLE: VIRTUALX_REQUIRED
# @DESCRIPTION:
#  Is a dependency on xorg-server and xhost needed?
#  Valid values are "always", "optional", and "manual".
#  "tests" is a synonym for "optional".
: ${VIRTUALX_REQUIRED:=optional}

# @ECLASS-VARIABLE: VIRTUALX_USE
# @DESCRIPTION:
#  If VIRTUALX_REQUIRED=optional, what USE flag should control
#  the dependency?
: ${VIRTUALX_USE:=test}

# @ECLASS-VARIABLE: VIRTUALX_DEPEND
# @DESCRIPTION:
#  Dep string available for use outside of eclass, in case a more
#  complicated dep is needed.
VIRTUALX_DEPEND="!prefix? ( x11-base/xorg-server )
	x11-apps/xhost"

case ${VIRTUALX_REQUIRED} in
	always)
		DEPEND="${VIRTUALX_DEPEND}"
		RDEPEND=""
		;;
	optional|tests)
		DEPEND="${VIRTUALX_USE}? ( ${VIRTUALX_DEPEND} )"
		RDEPEND=""
		IUSE="${VIRTUALX_USE}"
		;;
	manual)
		;;
	*)
		eerror "Invalid value (${VIRTUALX_REQUIRED}) for VIRTUALX_REQUIRED"
		eerror "Valid values are:"
		eerror "  always"
		eerror "  optional (default if unset)"
		eerror "  manual"
		die "Invalid value (${VIRTUALX_REQUIRED}) for VIRTUALX_REQUIRED"
		;;
esac

virtualmake() {
	local retval=0
	local OLD_SANDBOX_ON="${SANDBOX_ON}"
	local XVFB=$(type -p Xvfb)
	local XHOST=$(type -p xhost)

	# If $DISPLAY is not set, or xhost cannot connect to an X
	# display, then do the Xvfb hack.
	if [[ -n ${XVFB} && -n ${XHOST} ]] && \
	   ( [[ -z ${DISPLAY} ]] || ! (${XHOST} &>/dev/null) ) ; then
		export XAUTHORITY=
		# The following is derived from Mandrake's hack to allow
		# compiling without the X display

		einfo "Scanning for an open DISPLAY to start Xvfb ..."

		# We really do not want SANDBOX enabled here
		export SANDBOX_ON="0"

		local i=0
		XDISPLAY=$(i=0; while [[ -f /tmp/.X${i}-lock ]] ; do ((i++));done; echo ${i})

		# If we are in a chrooted environment, and there is already a
		# X server started outside of the chroot, Xvfb will fail to start
		# on the same display (most cases this is :0 ), so make sure
		# Xvfb is started, else bump the display number
		#
		# Azarah - 5 May 2002
		#
		# Changed the mode from 800x600x32 to 800x600x24 because the mfb
		# support has been dropped in Xvfb in the xorg-x11 pre-releases.
		# For now only depths up to 24-bit are supported.
		#
		# Sven Wegener <swegener@gentoo.org> - 22 Aug 2004
		#
		# Use "-fp built-ins" because it's only part of the default font path
		# for Xorg but not the other DDXs (Xvfb, Kdrive, etc). Temporarily fixes
		# bug 278487 until xorg-server is properly patched
		#
		# Rémi Cardona <remi@gentoo.org> (10 Aug 2009)
		${XVFB} :${XDISPLAY} -fp built-ins -screen 0 800x600x24 &>/dev/null &
		sleep 2

		local start=${XDISPLAY}
		while [[ ! -f /tmp/.X${XDISPLAY}-lock ]] ; do
			# Stop trying after 15 tries
			if ((XDISPLAY - start > 15)) ; then

				eerror ""
				eerror "Unable to start Xvfb."
				eerror ""
				eerror "'${XVFB} :${XDISPLAY} -fp built-ins -screen 0 800x600x24' returns:"
				eerror ""
				${XVFB} :${XDISPLAY} -fp built-ins -screen 0 800x600x24
				eerror ""
				eerror "If possible, correct the above error and try your emerge again."
				eerror ""
				die
			fi

			((XDISPLAY++))
			${XVFB} :${XDISPLAY} -fp built-ins -screen 0 800x600x24 &>/dev/null &
			sleep 2
		done

		# Now enable SANDBOX again if needed.
		export SANDBOX_ON="${OLD_SANDBOX_ON}"

		einfo "Starting Xvfb on \$DISPLAY=${XDISPLAY} ..."

		export DISPLAY=:${XDISPLAY}
		#Do not break on error, but setup $retval, as we need
		#to kill Xvfb
		${maketype} "$@"
		retval=$?

		#Now kill Xvfb
		kill $(cat /tmp/.X${XDISPLAY}-lock)
	else
		#Normal make if we can connect to an X display
		${maketype} "$@"
		retval=$?
	fi

	return ${retval}
}

# @FUNCTION: Xmake
# @DESCRIPTION: 
#  Same as "make", but set up the Xvfb hack if needed.
Xmake() {
	export maketype="make"
	virtualmake "$@"
}

# @FUNCTION: Xemake
# @DESCRIPTION: 
#  Same as "emake", but set up the Xvfb hack if needed.
Xemake() {
	export maketype="emake"
	virtualmake "$@"
}

# @FUNCTION: Xeconf
# @DESCRIPTION: 
#  Same as "econf", but set up the Xvfb hack if needed.
Xeconf() {
	export maketype="econf"
	virtualmake "$@"
}
