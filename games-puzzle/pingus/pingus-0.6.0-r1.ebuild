# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pingus/pingus-0.6.0-r1.ebuild,v 1.9 2004/09/20 20:23:58 mr_bones_ Exp $

inherit eutils flag-o-matic games

DESCRIPTION="free Lemmings clone"
HOMEPAGE="http://pingus.seul.org/"
SRC_URI="http://pingus.seul.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="nls opengl"

DEPEND=">=media-libs/hermes-1.3.2-r2
	=dev-games/clanlib-0.6.5*
	>=dev-libs/libxml2-2.5.6"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PV}-gcc3.patch"
	epatch "${FILESDIR}/${PV}-gcc34.patch" # bug 63773
	autoconf || die
}

src_compile() {
	append-flags -I${ROOT}/usr/include/clanlib-0.6.5
	append-ldflags -L${ROOT}/usr/lib/clanlib-0.6.5
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
	make install DESTDIR=${D} || die "make install failed"
	# pos install process ... FIXME
	mv "${D}/usr/games/"{games,bin}
	cd "${D}/usr/share/games"
	use nls && mv locale ../
	mv games/pingus .
	rm -rf games
	# end pos install process
	prepgamesdirs
}
