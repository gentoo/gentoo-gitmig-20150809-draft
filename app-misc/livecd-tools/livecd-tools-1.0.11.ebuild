# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/livecd-tools/livecd-tools-1.0.11.ebuild,v 1.1 2005/01/26 21:08:31 wolf31o2 Exp $

IUSE="opengl X"

DESCRIPTION="LiveCD tools (autoconfig, net-setup)"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~wolf31o2/sources/livecd-tools/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc ~hppa ~alpha"

RDEPEND="opengl? ( virtual/opengl )
	X? ( virtual/x11 )"

src_install() {
	exeinto /etc/init.d && doexe autoconfig && newexe spind.init spind
	if use x86
	then
		use X && dosbin x-setup
		use opengl && dosbin opengl-update-livecd openglify
	fi
	dosbin net-setup spind
}
