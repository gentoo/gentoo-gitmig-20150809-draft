# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/magnesium/magnesium-2.2.0b.ebuild,v 1.1 2005/04/16 02:38:04 anarchy Exp $

DESCRIPTION="Magnesium (also known as Curphoo X)) is a Yahoo! Chat client"
HOMEPAGE="http://mag.penguin-geek.com"
SRC_URI="http://mag.penguin-geek.com/downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="=gnome-base/libglade-2*
	=dev-python/pygtk-2*"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s,mg.glade,/usr/lib/${P}/mg.glade,g" mgh.py
}

src_install() {
	insinto /usr/lib/${P}
	doins *.py *.glade
	chmod +x ${D}/usr/lib/${P}/mg.py
	insinto /usr/lib/${P}/pixmaps
	doins pixmaps/*
	sed "s,@MAGNESIUMPATH@,${P},g" <${FILESDIR}/magnesium >magnesium || die
	dobin magnesium
	dodoc LICENSE
}
