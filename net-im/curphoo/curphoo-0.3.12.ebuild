# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/curphoo/curphoo-0.3.12.ebuild,v 1.3 2004/07/03 11:24:05 dholm Exp $

DESCRIPTION="Curphoo is a console Yahoo! Chat client written in Python"
HOMEPAGE="http://savannah.nongnu.org/projects/curphoo/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

DEPEND="virtual/libc >=dev-lang/python-2.1 >=sys-libs/ncurses-5.2"

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
	doman curphoo.1
}
