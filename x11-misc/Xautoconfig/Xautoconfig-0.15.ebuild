# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/Xautoconfig/Xautoconfig-0.15.ebuild,v 1.16 2005/01/02 15:06:44 corsair Exp $
# Author David Chamberlain <daybird@gentoo.org>

inherit eutils

DESCRIPTION="Xautoconfig is a PPC only config file generator for xfree86"
SRC_URI="http://ftp.penguinppc.org/projects/xautocfg/${P}.tar.gz"
HOMEPAGE="http://ftp.penguinppc.org/projects/xautocfg/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc -x86 -sparc "
IUSE=""

DEPEND="sys-apps/pciutils"

src_unpack() {

	if [ ${ARCH} != ppc ]
	then
		die "This is a PPC-only package"
	fi


	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Xautoconfig-0.15.diff || die
	cp ${FILESDIR}/XF4text.h ./
}

src_compile() {

	make || die "sorry, failed to compile Xautoconfig (PPC-only ebuild)"
}

src_install() {

	dodir /usr/X11R6/
	into /usr/X11R6/
	dobin Xautoconfig4

	dodoc ChangeLog

}
