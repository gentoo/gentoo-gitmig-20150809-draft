# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/magnesium/magnesium-1.0_pre10.ebuild,v 1.1 2003/09/14 21:25:38 mkennedy Exp $

MY_P=${PN}-${PV/1.0_/}
DESCRIPTION="Curphoo X (Magnesium) is a Yahoo chat client."
HOMEPAGE="http://magnesium.curphoo.org/"
SRC_URI="http://www.waduck.com/~curphoo/mg/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=gnome-base/libglade-2*
	=dev-python/pygtk-2*"

S=${WORKDIR}/${MY_P}

src_install() {
	insinto /usr/lib/${P}
	doins *.py
	chmod +x ${D}/usr/lib/${P}/mg.py
	sed "s,@MAGNESIUMPATH@,${P},g" <${FILESDIR}/magnesium >magnesium || die
	dobin magnesium
	dodoc CHANGES CREDITS README TODO gpl.txt
}
