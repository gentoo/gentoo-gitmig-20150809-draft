# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmxkb/wmxkb-1.2.2.ebuild,v 1.2 2005/06/16 08:29:10 dholm Exp $

IUSE=""

DESCRIPTION="Dockable keyboard layout switcher for Window Maker"
HOMEPAGE="http://www.geocities.com/wmalms/#WMXKB"
SRC_URI="http://www.geocities.com/wmalms/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~sparc ~x86"

DEPEND="virtual/x11"

src_install () {
	make DESTDIR=${D} BINDIR=${D}/usr/bin DOCDIR=${D}/usr/share/doc DATADIR=${D}/usr/share install
	dodoc README
	cd ${WORKDIR}/${P}/doc
	dodoc manual_body.html manual_title.html manual.book
}
