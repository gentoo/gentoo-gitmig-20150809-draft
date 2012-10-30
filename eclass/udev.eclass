# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/udev.eclass,v 1.3 2012/10/30 20:26:54 ssuominen Exp $

# @ECLASS: udev.eclass
# @MAINTAINER:
# udev-bugs@gentoo.org
# @BLURB: Default eclass for determining udev directories.
# @DESCRIPTION:
# Default eclass for determining udev directories.
# @EXAMPLE:
#
# @CODE
# inherit udev
#
# RDEPEND=">=sys-fs/udev-171-r6"
# DEPEND="${RDEPEND}"
#
# src_configure() {
#	econf --with-udevdir="$(udev_get_udevdir)"
# }
# @CODE

inherit toolchain-funcs

case ${EAPI:-0} in
	0|1|2|3|4|5) ;;
	*) die "${ECLASS}.eclass API in EAPI ${EAPI} not yet established."
esac

RDEPEND=""
DEPEND="virtual/pkgconfig"

# @FUNCTION: _udev_get_udevdir
# @INTERNAL
# @DESCRIPTION:
# Get unprefixed udevdir.
_udev_get_udevdir() {
	if $($(tc-getPKG_CONFIG) --exists udev); then
		echo "$($(tc-getPKG_CONFIG) --variable=udevdir udev)"
	else
		echo /lib/udev
	fi
}

# @FUNCTION: udev_get_udevdir
# @DESCRIPTION:
# Output the path for the udev directory (not including ${D}).
# This function always succeeds, even if udev is not installed.
# The fallback value is set to /lib/udev
udev_get_udevdir() {
	has "${EAPI:-0}" 0 1 2 && ! use prefix && EPREFIX=
	debug-print-function ${FUNCNAME} "${@}"

	echo "${EPREFIX}$(_udev_get_udevdir)"
}
