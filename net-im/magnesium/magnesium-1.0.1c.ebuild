# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/magnesium/magnesium-1.0.1c.ebuild,v 1.1 2004/04/06 03:44:54 mkennedy Exp $

MY_P=${PN}-${PV/1.0_/}
DESCRIPTION="Magnesium (also known as Curphoo X)) is a Yahoo! Chat client"
HOMEPAGE="http://magnesium.kicks-ass.net/ http://members.iinet.net.au/~texascm/mg/"
SRC_URI="http://magnesium.kicks-ass.net/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=gnome-base/libglade-2*
	=dev-python/pygtk-2*"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s,magnesium.glade,/usr/lib/${P}/magnesium.glade,g" ui.py
}

src_install() {
	insinto /usr/lib/${P}
	doins *.py *.glade
	chmod +x ${D}/usr/lib/${P}/mg.py
	sed "s,@MAGNESIUMPATH@,${P},g" <${FILESDIR}/magnesium >magnesium || die
	dobin magnesium
	dodoc AUTHORS CHANGELOG CREDITS INSTALL LICENSE README requests NEWS
}
