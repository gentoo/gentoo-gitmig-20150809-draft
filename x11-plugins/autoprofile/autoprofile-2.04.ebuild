# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/autoprofile/autoprofile-2.04.ebuild,v 1.3 2004/06/29 16:55:14 dholm Exp $

DESCRIPTION=" AutoProfile is a fully-featured profile manager for the popular instant messanger client Gaim."
HOMEPAGE="http://hkn.eecs.berkeley.edu/~casey/autoprofile/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="~net-im/gaim-0.77"
#RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:PREFIX = /usr/local:PREFIX = '${D}'/usr:g' Makefile
	#sed -i -e 's:GTK_PREFIX = $(PREFIX):GTK_PREFIX = /usr:g' Makefile
	sed -i -e 's:GAIM_TOP2 = ../gaim:GAIM_TOP2 = /usr/include/gaim:g' Makefile
}

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/lib/gaim
	doins	autoprofile.so

	dodoc COPYING CHANGELOG FORTUNE INSTALL README TODO
}
