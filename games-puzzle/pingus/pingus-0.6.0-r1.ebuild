# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pingus/pingus-0.6.0-r1.ebuild,v 1.13 2005/06/15 19:01:34 wolf31o2 Exp $

inherit eutils flag-o-matic games

DESCRIPTION="free Lemmings clone"
HOMEPAGE="http://pingus.seul.org/"
SRC_URI="http://pingus.seul.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls opengl"

DEPEND=">=media-libs/hermes-1.3.2-r2
	=dev-games/clanlib-0.6.5*
	>=dev-libs/libxml2-2.5.6"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc3.patch #28281
	epatch "${FILESDIR}"/${P}-gcc34.patch #63773
	autoconf || die "failed to update configure file in order to respect CFLAGS/LDFLAGS"
}

src_compile() {
	append-flags $(clanlib0.6-config --cflags)
	append-ldflags $(clanlib0.6-config --libs)
	replace-flags -Os -O2
	egamesconf \
		--with-bindir="${GAMES_BINDIR}" \
		--with-datadir="${GAMES_DATADIR_BASE}" \
		$(use_enable nls) \
		$(use_with opengl clanGL) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README TODO
	# pos install process ... FIXME
	mv "${D}/usr/games/games" "${D}/usr/games/bin"
	cd "${D}/usr/share/games"
	use nls && mv locale ../
	mv games/pingus .
	rm -rf games
	# end pos install process
	prepgamesdirs
}
