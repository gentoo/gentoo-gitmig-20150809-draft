# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xosd/xosd-0.7.0.ebuild,v 1.1 2002/06/04 16:11:27 bass Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="A simple library to display shaped text on your X display."
SRC_URI="http://www.ignavus.net/${P}.tar.gz"
HOMEPAGE="http://www.ignavus.net/software.html"
LICENSE="GPL-2"
DEPEND="x11-base/xfree"
RDEPEND="${DEPEND}"
SLOT="0"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${WORKDIR}/${P}
	patch Makefile < ${FILESDIR}/Makefile.patch || die	"patch failed"
}
src_compile() {
	emake || die
}

src_install () {
	INSTALLDIR=/usr/lib
	dobin osd_cat
	insinto ${INSTALLDIR}
	doins libxosd.so
	insinto ${INSTALLDIR}/xmms/General
	doins libxmms_osd.so
	insinto /usr/man/man1
	doins osd_cat.1
	insinto /usr/man/man3
	doins xosd.3

	dodoc AUTHORS ChangeLog COPYING NEWS README
}
