# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pouetchess/pouetchess-0.2.0.ebuild,v 1.2 2006/12/01 20:58:52 wolf31o2 Exp $

inherit eutils games

MY_PN=${PN/c/C}
DESCRIPTION="3D and open source chess game"
HOMEPAGE="http://pouetchess.sourceforge.net/"
SRC_URI="mirror://sourceforge/pouetchess/${PN}_src_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="debug"

RDEPEND=">=media-libs/libsdl-1.2.8
	media-libs/sdl-image
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext"

DEPEND="${RDEPEND}
	dev-util/scons"

S=${WORKDIR}/${PN}_src_${PV}

pkg_setup() {
	games_pkg_setup
	einfo "If you experience problems building pouetchess with nvidia drivers,"
	einfo "you can try:"
	einfo "eselect opengl set xorg-x11"
	einfo "emerge pouetchess"
	einfo "eselect opengl set nvidia"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# modify SConstruct file like seen on
	# http://permalink.gmane.org/gmane.comp.audio.csound.devel/6646
	# Fix up nvidia headers
	epatch \
		"${FILESDIR}"/${P}-sconstruct-sandbox.patch \
		"${FILESDIR}"/${P}-nvidia_glext.patch

	# Fix for LibSDL >= 1.2.10 detection
	sed -i \
		-e "s:sdlver.split('.') >= \['1','2','8'\]:sdlver.split('.') >= [1,2,8]:" \
		pouetChess.py \
		|| die "sed failed"
	sed -i \
		-e "/strip/d" \
		SConstruct \
		|| die "sed failed"
}

src_compile() {
	local myconf="prefix=${GAMES_PREFIX} datadir=${GAMES_DATADIR}/${PN}"
	use debug && myconf="${myconf} debug=1 strip=false"

	scons configure ${myconf} || die "scons configure failed"
	scons ${MAKEOPTS} || die "scons make failed"
}

src_install() {
	dogamesbin bin/"${MY_PN}" || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data/* || die "installing data failed"

	dodoc ChangeLog README

	doicon data/icons/${MY_PN}.png
	make_desktop_entry ${MY_PN} "pouetChess" ${MY_PN}.png "KDE;Qt;Game;BoardGame"

	prepgamesdirs
}
