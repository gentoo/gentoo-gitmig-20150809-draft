# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xbill/xbill-2.1-r2.ebuild,v 1.1 2007/12/05 22:52:43 tupone Exp $

inherit eutils autotools games

DESCRIPTION="A game about an evil hacker called Bill!"
HOMEPAGE="http://www.xbill.org/"
SRC_URI="http://www.xbill.org/download/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="gtk"

DEPEND="gtk? ( =x11-libs/gtk+-2* )
	!gtk? ( x11-libs/libXaw )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gtk2.patch
	eautoreconf
}

src_compile() {
	egamesconf \
		--disable-motif \
		$(use_enable gtk) \
		$(use_enable !gtk athena) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon pixmaps/icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} XBill ${PN}.xpm
	dodoc ChangeLog README
	prepgamesdirs
}
