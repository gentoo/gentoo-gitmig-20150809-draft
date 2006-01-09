# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.0.10.ebuild,v 1.1 2006/01/09 19:58:25 vanquirius Exp $

inherit toolchain-funcs

DESCRIPTION="http protocol ping-like program"
HOMEPAGE="http://www.vanheusden.com/httping/"
SRC_URI="http://www.vanheusden.com/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc64 ~hppa ~amd64 ~mips"
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
	export CC="$(tc-getCC)"
	emake ${makefile} || die "make failed"
}

src_install() {
	dobin httping || die
	dodoc readme.txt license.txt
}
