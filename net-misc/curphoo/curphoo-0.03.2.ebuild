# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/curphoo/curphoo-0.03.2.ebuild,v 1.2 2002/08/14 12:08:07 murphy Exp $

DESCRIPTION="Curphoo is a console Yahoo! Chat client written in Python"
HOMEPAGE="http://www.waduck.com/~curphoo/"
SRC_URI="http://www.waduck.com/~curphoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

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
	dodoc BUGS CHANGELOG README gpl.txt TODO floo2phoo
#	dolib.so cursexmodule.so YahooMD5module.so
	dodir /usr/lib/${P}
	mv curphoo curphoo.py
	cp *.py *.so ${D}/usr/lib/${P}

	mv curphoo.sh curphoo
	dobin curphoo
}
