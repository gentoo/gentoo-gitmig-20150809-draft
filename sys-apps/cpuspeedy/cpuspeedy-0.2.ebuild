# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpuspeedy/cpuspeedy-0.2.ebuild,v 1.3 2004/03/29 13:32:05 dholm Exp $

DESCRIPTION="A simple and easy to use program to control the speed and the voltage of CPUs on the fly."
SRC_URI="mirror://sourceforge/cpuspeedy/${P}.tar.gz"
HOMEPAGE="http://cpuspeedy.sourceforge.net/"
KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
RESTRICT="nomirror"
RDEPEND="virtual/python"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	einfo "There is nothing to compile."
}

src_install() {
	dosbin cpuspeedy cpuspeedy
	dodoc AUTHORS ChangeLog README
}

