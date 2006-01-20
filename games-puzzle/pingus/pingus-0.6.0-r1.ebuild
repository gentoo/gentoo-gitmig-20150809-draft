# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pingus/pingus-0.6.0-r1.ebuild,v 1.16 2006/01/20 08:26:17 mr_bones_ Exp $

inherit eutils flag-o-matic games

DESCRIPTION="free Lemmings clone"
HOMEPAGE="http://pingus.seul.org/"
SRC_URI="http://pingus.seul.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 x86"
IUSE="nls opengl"

DEPEND=">=media-libs/hermes-1.3.2-r2
	=dev-games/clanlib-0.6.5*
	>=dev-libs/libxml2-2.5.6"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc.patch #28281 #63773
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
	make_desktop_entry pingus "Pingus"
	prepgamesdirs
}
