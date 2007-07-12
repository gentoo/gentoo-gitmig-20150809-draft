# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/reed/reed-5.4.ebuild,v 1.8 2007/07/12 04:37:47 mr_bones_ Exp $

DESCRIPTION="This is a text pager (text file viewer), used to display etexts."
HOMEPAGE="http://www.sacredchao.net/software/reed/index.shtml"
SRC_URI=http://www.sacredchao.net/software/reed/${P}.tar.gz

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	sed -i -e "s:-O2:\$(CFLAGS):" Makefile.in
}

src_compile() {
	./configures --prefix=/usr || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS NEWS README
}
