# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim-blogger/gaim-blogger-0.79_p1.ebuild,v 1.2 2004/07/16 13:00:13 rizzo Exp $

MY_PV="${PV/_p/-}"
DESCRIPTION="Gaim-blogger is a protocol plugin for Gaim which makes use of Gaim's IM interface to post, edit, view and track blogs."
HOMEPAGE="http://gaim-blogger.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=net-im/gaim-0.79"
#RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:PREFIX = /usr/local:PREFIX = '${D}'/usr:g' Makefile
	sed -i -e 's:GTK_PREFIX = $(PREFIX):GTK_PREFIX = /usr:g' Makefile
	sed -i -e 's:GAIM_TOP = ../gaim:GAIM_TOP = /usr/include/gaim:g' Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/lib/gaim
	dodir /usr/share/pixmaps/gaim/status/default
	einstall || die

	dodoc COPYING ChangeLog
}
