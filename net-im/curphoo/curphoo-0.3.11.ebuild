# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/curphoo/curphoo-0.3.11.ebuild,v 1.2 2004/03/23 18:50:34 mholzer Exp $

DESCRIPTION="Curphoo is a console Yahoo! Chat client written in Python"
HOMEPAGE="http://savannah.nongnu.org/projects/curphoo/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc >=dev-lang/python-2.1 >=sys-libs/ncurses-5.2"

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
	dodoc BUGS CHANGELOG ChangeLog README TODO floo2phoo
	dodir /usr/lib/${P}
	mv curphoo curphoo.py
	cp *.py *.so ${D}/usr/lib/${P}
	mv curphoo.sh curphoo
	dobin curphoo
}
