# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/autotools.eclass,v 1.11 2005/08/28 17:23:48 azarah Exp $
#
# Author: Diego Pettenò <flameeyes@gentoo.org>
#
# This eclass is for handling autotooled software packages that
# needs to regenerate their build scripts.
#
# NB:  If you add anything, please comment it!

inherit eutils gnuconfig

DELEND="sys-devel/automake
	sys-devel/autoconf
	sys-devel/libtool"

# Internal function to run an autotools' tool
autotools_run_tool() {
	local STDERR_TARGET="${T}/$$.out"
	local PATCH_TARGET="${T}/$$.patch"
	local ris

	echo "***** $1 *****" > ${STDERR_TARGET%/*}/$1-${STDERR_TARGET##*/}
	echo >> ${STDERR_TARGET%/*}/$1-${STDERR_TARGET##*/}

	ebegin "Running $1"
	$@ >> ${STDERR_TARGET%/*}/$1-${STDERR_TARGET##*/} 2>&1
	ris=$?
	eend $ris

	if [[ $ris != 0 ]]; then
		echo
		eerror "Failed Running $1 !"
		eerror
		eerror "Include in your bugreport the contents of:"
		eerror
		eerror "  ${STDERR_TARGET%/*}/$1-${STDERR_TARGET##*/}"
		echo
		die "Failed Running $1 !"
	fi
}

# These functions runs the autotools using autotools_run_tool with the
# specified parametes. The name of the tool run is the same of the function
# without e prefix.
# They also force installing the support files for safety.
eaclocal() {
	autotools_run_tool aclocal "$@"
}

eautoheader() {
	autotools_run_tool autoheader "$@"
}

eautoconf() {
	autotools_run_tool autoconf "$@"
}

eautomake() {
	autotools_run_tool automake --add-missing --force-missing --copy "$@"
}

# This function mimes the behavior of autoreconf, but uses the different
# eauto* functions to run the tools. It doesn't accept parameters, but
# the directory with include files can be specified with M4DIR variable.
#
# Note: doesn't run autopoint right now, but runs gnuconfig_update.
eautoreconf() {
	local aclocal_opts

	[[ -n ${M4DIR} ]] && aclocal_opts="-I ${M4DIR}"

	eaclocal $aclocal_opts
	eautoconf
	eautoheader
	eautomake
	gnuconfig_update

	autotools_run_tool libtoolize --copy --force
}
