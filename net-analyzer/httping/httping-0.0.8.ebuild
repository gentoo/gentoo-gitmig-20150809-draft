# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-0.0.8.ebuild,v 1.2 2004/04/12 09:27:38 dholm Exp $

DESCRIPTION="http protocol ping-like program"
HOMEPAGE="http://www.vanheusden.com/httping/"
SRC_URI="http://www.vanheusden.com/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=sys-libs/ncurses-5"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:CFLAGS=:CFLAGS=${CFLAGS} :g" Makefile
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	dobin httping
	dodoc readme.txt license.txt
}
