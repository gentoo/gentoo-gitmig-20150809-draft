# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author David Chamberlain <daybird@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/Xautoconfig/Xautoconfig-0.15.ebuild,v 1.11 2003/09/05 23:29:05 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Xautoconfig is a PPC only config file generator for xfree86"
SRC_URI="http://ftp.penguinppc.org/projects/xautocfg/${P}.tar.gz"
HOMEPAGE="http://ftp.penguinppc.org/projects/xautocfg/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc -x86 -sparc "

DEPEND="sys-apps/pciutils"

src_unpack() {

	if [ ${ARCH} != ppc ]
	then
		die "This is a PPC-only package"
	fi


	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/Xautoconfig-0.15.diff || die
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
