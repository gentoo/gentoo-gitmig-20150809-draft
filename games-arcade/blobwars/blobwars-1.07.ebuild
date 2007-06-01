# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/blobwars/blobwars-1.07.ebuild,v 1.1 2007/06/01 01:53:22 nyhm Exp $

inherit gnome2-utils games

DESCRIPTION="Platform game about a blob and his quest to rescue MIAs from an alien invader"
HOMEPAGE="http://www.parallelrealities.co.uk/blobWars.php"
# download page has a lame PHP thing.
SRC_URI="mirror://gentoo/${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ~sparc x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-image
	virtual/libintl"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# don't build the pak file in the install stage.
	sed -i \
		-e "70d" \
		-e "/GAMEPLAYMANUAL/s:index:html/index:" \
		makefile \
		|| die "sed failed"
}

src_compile() {
	emake \
		DATADIR="${GAMES_DATADIR}/${PN}/" \
		DOCDIR="/usr/share/doc/${PF}/" \
		LOCALEDIR="/usr/share/locale/" \
		|| die "emake failed"
	emake buildpak || die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		BINDIR="${D}/${GAMES_BINDIR}/" \
		DATADIR="${D}/${GAMES_DATADIR}/${PN}/" \
		DOCDIR="${D}/usr/share/doc/${PF}/" \
		ICONDIR="${D}/usr/share/icons/hicolor/" \
		DESKTOPDIR="${D}/usr/share/applications/" \
		LOCALEDIR="${D}/usr/share/locale/" \
		install || die "emake install failed"
	# now make the docs Gentoo friendly.
	dohtml "${D}/usr/share/doc/${PF}/"*
	dodoc "${D}/usr/share/doc/${PF}/"{CHANGES,HACKING,PORTING,README}
	rm -f "${D}/usr/share/doc/${PF}/"*.{png,gif,html} \
		"${D}/usr/share/doc/${PF}/"{CHANGES,HACKING,LICENSE,PORTING,README}
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
