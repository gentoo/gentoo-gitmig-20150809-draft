# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-txt-client/ggz-txt-client-0.0.13.ebuild,v 1.6 2006/10/06 22:39:45 nyhm Exp $

inherit games

DESCRIPTION="The textbased client for GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="http://ftp.belnet.be/packages/ggzgamingzone/ggz/${PV}/${P}.tar.gz
	http://mirrors.ibiblio.org/pub/mirrors/ggzgamingzone/ggz/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ppc x86"
IUSE=""

RDEPEND="~dev-games/ggz-client-libs-${PV}
	sys-libs/ncurses
	sys-libs/readline
	virtual/libintl"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:$(prefix)/share:/usr/share:' \
		po/Makefile.in || die "sed failed"
}

src_compile() {
	egamesconf --datadir=/usr/share || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS QuickStart.GGZ README* TODO
	prepgamesdirs
}
