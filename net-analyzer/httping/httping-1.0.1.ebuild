# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.0.1.ebuild,v 1.1 2005/04/05 11:45:21 ka0ttic Exp $

DESCRIPTION="http protocol ping-like program"
HOMEPAGE="http://www.vanheusden.com/httping/"
SRC_URI="http://www.vanheusden.com/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc64 ~hppa ~amd64"
IUSE="ssl"

DEPEND=">=sys-libs/ncurses-5"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s|^\(CFLAGS=\)-O2\(.*\)$|\1${CFLAGS} \2|g" Makefile* || \
		die "sed Makefile failed"
}

src_compile() {
	local makefile
	use ssl || makefile="-f Makefile.nossl"
	emake ${makefile} || die "make failed"
}

src_install() {
	dobin httping || die
	dodoc readme.txt license.txt
}
