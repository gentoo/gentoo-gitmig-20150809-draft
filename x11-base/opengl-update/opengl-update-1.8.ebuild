# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/opengl-update/opengl-update-1.8.ebuild,v 1.2 2004/07/17 09:43:00 cyfred Exp $

DESCRIPTION="Utility to change the OpenGL interface being used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
GLEXT="20040714"

DEPEND="virtual/libc"

pkg_setup() {
	if ( has_version "x11-base/xfree" || has_version "<x11-base/xorg-x11-6.7.0-r2" )
	then
		echo
		ewarn "This version of opengl-update is designed for use with xorg-x11-6.7.0-r2"
		ewarn "Please mask this version of opengl-update by doing the following"
		echo
		ewarn "echo \"=x11-base/opengl-update-1.8\" >> /etc/portage/pacakge.mask"
		echo
		ewarn "Alternatively you can upgrade your system to x11-base/xorg-x11-6.7.0-r2"
		echo

		die "Please mask this pacakge"
	fi
}

src_install() {
	newsbin ${FILESDIR}/opengl-update-${PV} opengl-update || die

	# Install default glext.h
	dodir /usr/lib/opengl/global/include
	insinto /usr/lib/opengl/global/include
	newins ${FILESDIR}/glext.h-${GLEXT} glext.h || die
}
