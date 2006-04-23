# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/blobwars/blobwars-1.04.ebuild,v 1.7 2006/04/23 11:22:28 tupone Exp $

inherit eutils games

DESCRIPTION="Platform game about a blob and his quest to rescue MIAs from an alien invader"
HOMEPAGE="http://www.parallelrealities.co.uk/blobWars.php"
# download page has a lame PHP thing.
SRC_URI="mirror://gentoo/${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ~sparc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.5
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-image"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-be_pak.diff \
		"${FILESDIR}/${P}"-gcc41.patch
}

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
	dodoc "${D}/usr/share/doc/${PF}/"{CHANGES,HACKING,PORTING,README}
	rm -f "${D}/usr/share/doc/${PF}/"*.{png,gif,html} \
		"${D}/usr/share/doc/${PF}/"{CHANGES,HACKING,LICENSE,PORTING,README}
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	echo
	ewarn "${PN} ${PV} may not be save-game compatible with previous versions."
	einfo "Please remove the directory ~/.parallelrealities/blobwars before playing if it exists."
	echo
	einfo "If you have older save files and you wish to continue those games,"
	einfo "you'll need to remerge the version with which you started"
	einfo "those save-games."
	echo
}
