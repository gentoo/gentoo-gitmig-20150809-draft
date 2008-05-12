# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/geresh/geresh-0.6.3.ebuild,v 1.1 2008/05/12 05:22:07 drac Exp $

inherit autotools eutils

DESCRIPTION="A simple multi-lingual console text editor with bidi & utf support"
HOMEPAGE="http://www.typo.co.il/~mooffie/geresh/"
SRC_URI="http://www.typo.co.il/~mooffie/geresh/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="spell"

DEPEND="virtual/libiconv
	dev-libs/fribidi
	sys-libs/ncurses
	spell? ( virtual/aspell-dict )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch \
		"${FILESDIR}"/${P}-gcc43.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS README THANKS TODO
}
