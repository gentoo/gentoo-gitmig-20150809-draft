# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/netpanzer/netpanzer-0.8.2.ebuild,v 1.8 2011/08/07 17:12:28 armin76 Exp $

EAPI=2
inherit eutils games

DATAVERSION="0.8"
DESCRIPTION="Fast-action multiplayer strategic network game"
HOMEPAGE="http://netpanzer.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2
	mirror://berlios/${PN}/${PN}-data-${DATAVERSION}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="dedicated"

RDEPEND="dedicated? ( app-misc/screen )
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	dev-games/physfs"
DEPEND="${RDEPEND}
	dev-util/ftjam"

PATCHES=( "${FILESDIR}"/${P}-gcc43.patch )

src_configure() {
	egamesconf || die
	cd "${WORKDIR}"/${PN}-data-${DATAVERSION} \
		&& egamesconf || die
}

src_compile() {
	jam -q || die "jam failed"

	cd "${WORKDIR}"/${PN}-data-${DATAVERSION}
	jam -q || die "jam failed (on data package)"
}

src_install() {
	jam -sDESTDIR="${D}" -sappdocdir=/usr/share/doc/${PF} install \
		|| die "jam install failed"

	cd "${WORKDIR}"/${PN}-data-${DATAVERSION}
	jam -sDESTDIR="${D}" -sappdocdir=/usr/share/doc/${PF} install \
		|| die "jam install failed (data package)"

	if use dedicated ; then
		newinitd "${FILESDIR}"/${PN}.rc ${PN} || die "newinitd failed"
		sed -i \
			-e "s:GAMES_USER_DED:${GAMES_USER_DED}:" \
			-e "s:GENTOO_DIR:${GAMES_BINDIR}:" \
			"${D}"/etc/init.d/${PN} \
			|| die "sed failed"

		insinto /etc
		doins "${FILESDIR}"/${PN}-ded.ini || die "doins failed"
		dogamesbin "${FILESDIR}"/${PN}-ded || die "dogamesbin failed"
		sed -i \
			-e "s:GENTOO_DIR:${GAMES_BINDIR}:" \
			"${D}/${GAMES_BINDIR}"/${PN}-ded \
			|| die "sed failed"
	fi

	rm -rf "${D}/${GAMES_DATADIR}"/{applications,pixmaps}
	doicon "${S}"/${PN}.png
	make_desktop_entry ${PN} NetPanzer
	prepgamesdirs
}
