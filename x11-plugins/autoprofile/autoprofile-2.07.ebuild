# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/autoprofile/autoprofile-2.07.ebuild,v 1.5 2004/07/16 13:09:56 rizzo Exp $

DESCRIPTION=" AutoProfile is a fully-featured profile manager for the popular instant messanger client Gaim."
HOMEPAGE="http://hkn.eecs.berkeley.edu/~casey/autoprofile/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=net-im/gaim-0.79"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:PREFIX = /usr/local:PREFIX = '${D}'/usr:g' Makefile
}

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/lib/gaim
	doins	autoprofile.so

	dodoc COPYING CHANGELOG FORTUNE INSTALL README TODO
}
