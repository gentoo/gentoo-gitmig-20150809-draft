# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alephone-infinity/alephone-infinity-1.ebuild,v 1.3 2007/02/13 23:21:39 nyhm Exp $

inherit eutils games

DESCRIPTION="Aleph One - Marathon Infinity"
HOMEPAGE="http://trilogyrelease.bungie.org/"
SRC_URI="http://trilogyrelease.bungie.org/files/MarathonInfinity.zip
	mirror://gentoo/${PN}.png"

LICENSE="bungie-marathon"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=games-fps/alephone-20060506-r1"
DEPEND="app-arch/unzip"

S=${WORKDIR}/Marathon\ Infinity

src_install() {
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r * || die "doins failed"

	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry "alephone.sh infinity" "Aleph One - Marathon Infinity"

	# Make sure the extra dirs exist in case the user wants to add some data
	keepdir "${GAMES_DATADIR}"/${PN}/{Scripts,"Physics Models",Textures,Themes}

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "To play this scenario, run:"
	elog "alephone.sh infinity"
}
