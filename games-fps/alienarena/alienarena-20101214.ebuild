# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alienarena/alienarena-20101214.ebuild,v 1.3 2011/02/10 11:08:58 phajdan.jr Exp $

EAPI=2
inherit autotools eutils games

MY_PN=alienarena-7_50
DESCRIPTION="Fast-paced multiplayer deathmatch game"
HOMEPAGE="http://red.planetarena.org/"
SRC_URI="http://icculus.org/alienarena/Files/${MY_PN}-linux${PV}.tar.gz"

LICENSE="GPL-2 free-noncomm"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="dedicated +dga +vidmode"

UIRDEPEND="virtual/jpeg
	media-libs/openal
	media-libs/libvorbis
	media-libs/freetype:2
	dev-games/ode
	virtual/glu
	virtual/opengl
	dga? ( x11-libs/libXxf86dga )
	vidmode? ( x11-libs/libXxf86vm )
	net-misc/curl"
UIDEPEND="dga? ( x11-proto/xf86dgaproto )
	vidmode? ( x11-proto/xf86vidmodeproto )"
RDEPEND="!dedicated? ( ${UIRDEPEND} )"
DEPEND="${RDEPEND}
	!dedicated? ( ${UIDEPEND} )
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_PN/_/.}

src_prepare() {
	epatch "${FILESDIR}"/${P}-nodocs.patch
	sed -i -e '/aa.png/d ' game_data.am || die
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-silent-rules \
		--disable-dependency-tracking \
		$(use_enable !dedicated client) \
		$(use_with dga xf86dga) \
		$(use_with vidmode xf86vm)
}

src_install() {
	emake DESTDIR="${D}" install || die

	mv "${D}${GAMES_BINDIR}/crx-ded" "${D}${GAMES_BINDIR}/${PN}-ded" || die
	if ! use dedicated ; then
		mv "${D}${GAMES_BINDIR}/crx" "${D}${GAMES_BINDIR}/${PN}" || die
		make_desktop_entry ${PN} "Alien Arena"
		newicon aa.png ${PN}.png
	fi

	dodoc docs/README.txt README
	prepgamesdirs
}
