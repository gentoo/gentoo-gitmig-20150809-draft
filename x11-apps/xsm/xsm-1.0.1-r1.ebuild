# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xsm/xsm-1.0.1-r1.ebuild,v 1.12 2010/11/01 12:55:52 scarabeus Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="X Session Manager"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""
RDEPEND="x11-libs/libXaw
	!elibc_Darwin? ( net-misc/netkit-rsh )"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="--disable-xprint"

pkg_setup() {
	# (#158056) /usr/$(get_libdir)/X11/xsm could be a symlink
	local XSMPATH="${EROOT}usr/$(get_libdir)/X11/xsm"
	if [[ -L ${XSMPATH} ]]; then
		einfo "Removing symlink ${XSMPATH}"
		rm -f ${XSMPATH} || die "failed to remove symlink ${XSMPATH}"
	fi
}
