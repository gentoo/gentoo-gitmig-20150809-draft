# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/blobwars/blobwars-0.52.ebuild,v 1.1 2004/05/30 09:17:32 mr_bones_ Exp $

inherit games

DESCRIPTION="Platform game about a blob and his quest to rescue MIAs from an alien invader"
HOMEPAGE="http://www.parallelrealities.co.uk/blobWars.php"
# download page has a lame PHP thing.
SRC_URI="mirror://gentoo/${P}-1.tar.gz"

KEYWORDS="x86 ~alpha"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.5
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-image"

src_compile() {
	emake \
		BINDIR="${GAMES_BINDIR}/" \
		DATADIR="${GAMES_DATADIR}/parallelrealities/" \
		DOCDIR="/usr/share/doc/${PF}/" \
		ICONDIR="/usr/share/icons/" \
		KDE="/usr/share/applnk/Games/Arcade/" \
		GNOME="/usr/share/gnome/apps/Games/" \
		|| die "emake failed"
}

src_install() {
	make \
		BINDIR="${D}/${GAMES_BINDIR}/" \
		DATADIR="${D}/${GAMES_DATADIR}/parallelrealities/" \
		DOCDIR="${D}/usr/share/doc/${PF}/" \
		ICONDIR="${D}/usr/share/icons/" \
		KDE="${D}/usr/share/applnk/Games/Arcade/" \
		GNOME="${D}/usr/share/gnome/apps/Games/" \
		install || die "make install failed"

	# now make the docs Gentoo friendly.
	dohtml "${D}/usr/share/doc/${PF}/"*
	dodoc "${D}/usr/share/doc/${PF}/"{CHANGES,PORTING,README,changeLog}
	rm -f "${D}/usr/share/doc/${PF}/"*.{png,gif,html} \
		"${D}/usr/share/doc/${PF}/"{CHANGES,LICENSE,PORTING,README,changeLog}

	prepgamesdirs
}
