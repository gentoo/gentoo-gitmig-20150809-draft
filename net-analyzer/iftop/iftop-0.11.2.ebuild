# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iftop/iftop-0.11.2.ebuild,v 1.1 2003/01/04 02:01:11 aliz Exp $

IUSE=""
MY_PV="${PV:0:4}pre2"

S=${WORKDIR}/${PN}-${MY_PV}
DESCRIPTION="display bandwidth usage on an interface"
SRC_URI="http://www.ex-parrot.com/~pdw/iftop/download/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://www.ex-parrot.com/~pdw/iftop/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="sys-libs/ncurses
	net-libs/libpcap"


src_compile() {
	econf || die
	emake || die
}

src_install() {
	dosbin iftop
	doman iftop.8
	dodoc COPYING CHANGES README
}

