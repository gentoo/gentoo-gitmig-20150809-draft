# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/grande-KXL/grande-KXL-0.6.ebuild,v 1.5 2005/03/20 06:07:40 vapier Exp $

inherit eutils games

DESCRIPTION="ZANAC type game"
HOMEPAGE="http://kxl.hn.org/"
SRC_URI="http://kxl.hn.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-games/KXL-1.1.7"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-configure.in.patch
	aclocal && \
	automake -c -a && \
	autoconf || die "autotools failed"
}

src_compile() {
	egamesconf \
		--datadir="${GAMES_DATADIR_BASE}" \
		|| die
	emake || die
}

src_install() {
	dodir "${GAMES_STATEDIR}"
	make DESTDIR="${D}" install || die
	dodoc ChangeLog README
	prepgamesdirs
}
