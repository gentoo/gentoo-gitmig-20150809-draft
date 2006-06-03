# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alephone-infinity/alephone-infinity-1.ebuild,v 1.1 2006/06/03 22:07:59 tupone Exp $

inherit eutils games

MY_PN_1=MarathonInfinity
MY_PN_2="Marathon Infinity"

HOMEPAGE="http://trilogyrelease.bungie.org/"
SRC_URI="http://trilogyrelease.bungie.org/files/${MY_PN_1}.zip"
RESTRICT="nomirror"
LICENSE="bungie-marathon"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DESCRIPTION="Aleph One - Marathon Infinity"
RDEPEND=">=games-fps/alephone-20060506-r1"
DEPEND="app-arch/unzip"

S=${WORKDIR}/${MY_PN_2}

src_install() {
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r *

	newicon "${FILESDIR}"/AlephOne.png ${PN}.png
	make_desktop_entry "alephone.sh infinity" "Aleph One - Marathon Infinity" ${PN}.png

	# Make sure the extra dirs exist in case the user wants to add some data
	keepdir "${GAMES_DATADIR}"/${PN}/{Scripts,"Physics Models",Textures,Themes}

	# Make sure all the right stuff has all the right permissions
	prepgamesdirs
}

pkg_postinst() {
	einfo "To play this scenario, run:"
	einfo "alephone.sh infinity"
	games_pkg_postinst
}
