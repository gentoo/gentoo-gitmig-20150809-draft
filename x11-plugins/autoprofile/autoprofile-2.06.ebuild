# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/autoprofile/autoprofile-2.06.ebuild,v 1.1 2004/05/31 16:35:33 rizzo Exp $

DESCRIPTION="Gaim plugin that creates away messages and profiles using dynamic components."
HOMEPAGE="http://hkn.eecs.berkeley.edu/~casey/autoprofile/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="~net-im/gaim-0.78"
#RDEPEND=""

#S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:PREFIX = /usr/local:PREFIX = '${D}'/usr:g' Makefile
	#sed -i -e 's:GTK_PREFIX = $(PREFIX):GTK_PREFIX = /usr:g' Makefile
	#sed -i -e 's:GAIM_TOP2 = ../gaim:GAIM_TOP2 = /usr/include/gaim:g' Makefile
}

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/lib/gaim
	doins	autoprofile.so

	dodoc COPYING CHANGELOG COPYRIGHT INSTALL README TODO
}
