# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/livecd-tools/livecd-tools-1.0.3.ebuild,v 1.1 2004/05/14 15:58:28 wolf31o2 Exp $

IUSE="opengl X"

DESCRIPTION="LiveCD tools (autoconfig, net-setup)"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~wolf31o2/${P}.tar.bz2
		mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64"

DEPEND=""

S=${WORKDIR}/${P}

src_install() {
	use x86 && exeinto /etc/init.d && doexe autoconfig
	use x86 && use X && dosbin x-setup
	use opengl && dosbin opengl-update openglify
	dosbin net-setup
}
