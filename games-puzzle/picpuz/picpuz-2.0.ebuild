# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/picpuz/picpuz-2.0.ebuild,v 1.2 2009/11/26 19:58:11 maekke Exp $

EAPI=2
inherit eutils games

DESCRIPTION="a jigsaw puzzle program"
HOMEPAGE="http://kornelix.squarespace.com/picpuz/"
SRC_URI="http://kornelix.squarespace.com/storage/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PATCHES=( "${FILESDIR}"/${P}-build.patch )

src_compile() {
	emake \
		BINDIR="${GAMES_BINDIR}" \
		DATADIR="${GAMES_DATADIR}"/${PN} \
		DOCDIR=/usr/share/doc/${PF}/html \
		|| die "emake failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* locales || die "doins failed"
	doicon data/icons/${PN}.png
	make_desktop_entry ${PN} Picpuz
	dohtml -r doc/{userguide-en.html,images}
	dodoc doc/{CHANGES,README,TRANSLATIONS}
	prepgamesdirs
}
