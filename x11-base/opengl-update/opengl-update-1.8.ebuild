# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/opengl-update/opengl-update-1.8.ebuild,v 1.1 2004/07/17 03:25:31 cyfred Exp $

DESCRIPTION="Utility to change the OpenGL interface being used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
GLEXT="20040714"

DEPEND="virtual/libc
	>=x11-base/xorg-x11-6.7.0-r2"

src_install() {
	newsbin ${FILESDIR}/opengl-update-${PV} opengl-update || die

	# Install default glext.h
	dodir /usr/lib/opengl/global/include
	insinto /usr/lib/opengl/global/include
	newins ${FILESDIR}/glext.h-${GLEXT} glext.h || die
}
