# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmxkb/wmxkb-1.2.0.ebuild,v 1.1 2004/01/04 05:05:08 port001 Exp $

IUSE=""

DESCRIPTION="Dockable keyboard layout switcher for Window Maker"
HOMEPAGE="http://www.geocities.com/wmalms/#WMXKB"
SRC_URI="http://www.geocities.com/wmalms/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND="virtual/x11"

src_install () {
	make DESTDIR=${D} BINDIR=${D}/usr/bin DOCDIR=${D}/usr/share/doc DATADIR=${D}/usr/share install
	dodoc README
	cd ${WORKDIR}/${P}/doc
	dodoc manual_body.html manual_title.html manual.book
}
