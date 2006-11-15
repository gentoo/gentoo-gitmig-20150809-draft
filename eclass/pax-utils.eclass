# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/pax-utils.eclass,v 1.2 2006/11/15 22:14:25 kevquinn Exp $

# Author:
#	Kevin F. Quinn <kevquinn@gentoo.org>
#
# This eclass provides support for manipulating PaX markings on ELF
# binaries, wrapping the use of the chpax and paxctl utilities.

inherit eutils

##### pax-mark ####
# Mark a file for PaX, with the provided flags, and log it into
# a PaX database.  Returns non-zero if flag marking failed.
#
# If paxctl is installed, but not chpax, then the legacy
# EI flags (which are not strip-safe) will not be set.
# If neither are installed, falls back to scanelf (which
# is always present, but currently doesn't quite do all
# that paxctl can do).

pax-mark() {
	local flags fail=0
	flags=$1
	shift
	if [[ -x /sbin/chpax ]]; then
		einfo "Legacy EI PaX marking $* with ${flags}"
		/sbin/chpax -${flags} $* || fail=1
	fi
	if [[ -x /sbin/paxctl ]]; then
		einfo "PT PaX marking $* with ${flags}"
		/sbin/paxctl -${flags} $* ||
		/sbin/paxctl -c${flags} $* ||
		/sbin/paxctl -C${flags} $* || fail=1
	elif [[ -x /usr/bin/scanelf ]]; then
		einfo "Fallback PaX marking $* with ${flags}"
		/usr/bin/scanelf -Xxz ${flags} $*
	else
		ewarn "Failed to set PaX markings ${flags} for files $*.  Executables may be killed by PaX kernels."
		fail=1
	fi
	return ${fail}
}

##### host-is-pax
# Indicates whether the build machine has PaX or not; intended for use
# where the build process must be modified conditionally in order to satisfy PaX.
host-is-pax() {
	# We need procfs to work this out.  PaX is only available on Linux,
	# so result is always false on non-linux machines (e.g. Gentoo/*BSD)
	[[ -e /proc/self/status ]] || return 1
	grep ^PaX: /proc/self/status > /dev/null
	return $?
}
