# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/jmcce/jmcce-1.4_rc2.ebuild,v 1.1 2003/05/25 15:10:52 liquidx Exp $

MY_PV=${PV/_rc/RC}
S=${WORKDIR}/${PN}-${MY_PV}
DESCRIPTION="A Chinese Console supporting BIG5, GB and Japanese input."
HOMEPAGE="http://jmcce.slat.org"
SRC_URI="http://zope.slat.org/Project/Jmcce/DOWNLOAD/${PN}-${MY_PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/svgalib-1.4.3
	>=sys-libs/ncurses-4.2"

MAKEOPTS="${MAKEOPTS} -j1"
	
src_compile() {
	cd ${S}
	
	./genconf.sh
	econf --sysconfdir=/etc/jmcce
	emake || die "make failed"
}

src_install() {
	dodir /etc/jmcce
	
	make DESTDIR=${D} install || die "install failed"
	
	dodir /usr/share/doc
	mv ${D}/usr/share/doc/jmcce-1.4RC2 ${D}/usr/share/doc/${PF}
	doman doc/jmcce.1
}


