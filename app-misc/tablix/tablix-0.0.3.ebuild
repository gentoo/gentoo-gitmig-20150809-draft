# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tablix/tablix-0.0.3.ebuild,v 1.3 2004/03/14 10:59:04 mr_bones_ Exp $

DESCRIPTION="Tablix is a high school timetable generator written in C."
HOMEPAGE="http://users.kiss.si/~k4fe1336/tablix/"
SRC_URI="http://users.kiss.si/%7Ek4fe1336/tablix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.4.3"

src_compile() {
	#local myconf="--with-xml-prefix=/usr/include/libxml2/libxml/"
	local myconf="--disable-xmltest"
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
}
