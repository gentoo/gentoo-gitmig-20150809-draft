# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/bluefish/bluefish-0.9.ebuild,v 1.11 2004/05/31 22:12:03 vapier Exp $

DESCRIPTION="Bluefish is a GTK HTML editor for the experienced web designer or programmer"
HOMEPAGE="http://bluefish.openoffice.nl/"
SRC_URI="http://pkedu.fbt.eitn.wau.nl/~olivier/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	dev-libs/libpcre"
RDEPEND="${DEPEND}
	sys-devel/gettext"

src_install() {
	sed -i -e "s:"/usr/share/pixmaps/b":"${D}/usr/share/pixmaps/b":g" Makefile
	cd data
	sed -i -e "s:"/usr/share":"${D}/usr/share":g" Makefile
	dodir /usr/bin
	dodir /usr/share/pixmaps
	dodir /usr/share/applications
	cd ${S}
	einstall datadir=${D}/usr/share \
		pkgdatadir=${D}/usr/share/bluefish
#		pixmapsdir=${D}/usr/share/pixmap \
}
