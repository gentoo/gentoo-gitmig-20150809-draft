# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/angband/angband-3.0.5.ebuild,v 1.6 2004/10/18 21:11:22 gustavoz Exp $

inherit games

DESCRIPTION="A roguelike dungeon exploration game based on the books of J.R.R.Tolkien"
HOMEPAGE="http://thangorodrim.net/"
SRC_URI="ftp://clockwork.dementia.org/${PN}/Source/${P}.tar.gz"

LICENSE="Moria"
SLOT="0"
KEYWORDS="x86 ppc ~amd64 ~sparc"
IUSE="X gtk"

RDEPEND="virtual/libc
	>=sys-libs/ncurses-5
	gtk? (
		=x11-libs/gtk+-1.2*
		dev-libs/glib
		virtual/x11
	)
	X? ( virtual/x11 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:/games/:/:" configure \
		|| die "sed configure failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--bindir="${GAMES_BINDIR}" \
		--with-setgid="${GAMES_GROUP}" \
		$(use_enable gtk) \
		$(use_with X x) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS THANKS TODO changes.txt compile.txt readme.txt
	find "${D}${GAMES_DATADIR}" -type f -exec chmod a-x \{\} \;
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	chmod -R g+w "${ROOT}${GAMES_DATADIR}"/angband/lib/{apex,save,user}
}
