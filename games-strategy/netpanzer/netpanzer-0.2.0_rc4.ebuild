# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/netpanzer/netpanzer-0.2.0_rc4.ebuild,v 1.2 2005/01/24 20:29:44 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Fast-action multiplayer strategic network game"
HOMEPAGE="http://netpanzer.berlios.de/"
DATAVERSION="0.2.0"
SRC_URI="http://download.berlios.de/netpanzer/netpanzer-${PV}.tar.bz2
	http://download.berlios.de/netpanzer/netpanzer-data-${DATAVERSION}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="dedicated"

RDEPEND="dedicated? ( app-misc/screen )
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-image-1.2
	>=dev-games/physfs-0.1.9"
DEPEND="${RDEPEND}
	>=dev-util/jam-2.5"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/${PN}-data-${DATAVERSION}/"
}

src_compile() {
	egamesconf || die
	jam -q || die "jam failed"

	einfo "Working in ${WORKDIR}/${PN}-data-${DATAVERSION}/"
	cd ${WORKDIR}/${PN}-data-${DATAVERSION}/
	egamesconf || die
	jam -q || die "jam failed (on data package)"
}

src_install() {
	jam -sDESTDIR="${D}" -sappdocdir=/usr/share/doc/${PF} install || die "jam install failed"

	cd "${WORKDIR}/${PN}-data-${DATAVERSION}/"
	jam -sDESTDIR=${D} -sappdocdir=/usr/share/doc/${PF} install || die "jam install failed (data package)"

	if use dedicated ; then
	    exeinto /etc/init.d
		newexe "${FILESDIR}/netpanzer.rc" netpanzer || die "newexe failed"
		dosed "s:GAMES_USER_DED:${GAMES_USER_DED}:" /etc/init.d/netpanzer
		dosed "s:GENTOO_DIR:${GAMES_BINDIR}:" /etc/init.d/netpanzer

		insinto /etc
		doins "${FILESDIR}/netpanzer-ded.ini" || die "newins failed"
		exeinto ${GAMES_BINDIR}
		doexe "${FILESDIR}/netpanzer-ded" || die "newexe failed"
		dosed "s:GENTOO_DIR:${GAMES_BINDIR}:" ${GAMES_BINDIR}/netpanzer-ded
	fi

	make_desktop_entry netpanzer NetPanzer netpanzer.png

	prepgamesdirs
}
