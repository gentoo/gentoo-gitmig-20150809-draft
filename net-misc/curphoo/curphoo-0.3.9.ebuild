# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/curphoo/curphoo-0.3.9.ebuild,v 1.1 2003/09/28 11:34:08 mkennedy Exp $

DESCRIPTION="Curphoo is a console Yahoo! Chat client written in Python"
HOMEPAGE="http://www.waduck.com/~curphoo/
	https://savannah.nongnu.org/projects/curphoo/"
SRC_URI="http://savannah.nongnu.org/download/curphoo/curphoo.pkg/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

RDEPEND="virtual/glibc >=dev-lang/python-2.1 >=sys-libs/ncurses-5.2"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	cp ${FILESDIR}/curphoo.sh curphoo.sh.templ
	sed -e "s#@PHOOPATH@#${P}#" curphoo.sh.templ >curphoo.sh
}

src_compile() {
	make || die
}

src_install () {
	dodoc BUGS CHANGELOG README TODO floo2phoo
	dodir /usr/lib/${P}
	mv curphoo curphoo.py
	cp *.py *.so ${D}/usr/lib/${P}
	mv curphoo.sh curphoo
	dobin curphoo
}
