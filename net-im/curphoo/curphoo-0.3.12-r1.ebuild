# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/curphoo/curphoo-0.3.12-r1.ebuild,v 1.1 2005/08/08 16:13:56 mkennedy Exp $

inherit eutils

DESCRIPTION="Curphoo is a console Yahoo! Chat client written in Python"
HOMEPAGE="http://savannah.nongnu.org/projects/curphoo/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/${P}-amd64.patch.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

DEPEND=">=dev-lang/python-2.1
	>=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	epatch ${P}-amd64.patch || die
	epatch ${FILESDIR}/${PV}-session-server-gentoo.patch || die
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
