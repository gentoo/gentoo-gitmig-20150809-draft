# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake2-textures/quake2-textures-0_beta8.ebuild,v 1.1 2006/06/27 20:22:47 wolf31o2 Exp $

inherit eutils versionator games

MY_PV=$(get_version_component_range 2-2)
MY_PV=${MY_PV/beta/}

DESCRIPTION="High-resolution textures for Quake 2"
HOMEPAGE="http://jdolan.dyndns.org/trac/wiki/Retexture"
SRC_URI="http://jdolan.dyndns.org/jaydolan/tmp/retexture/pak${MY_PV}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

S=${WORKDIR}
dir=${GAMES_DATADIR}/quake2

src_install() {
	insinto "${dir}"/baseq2
	doins *.pak || die "doins *.pak failed"

	dodoc README

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	einfo "Use a recent Quake 2 client to take advantage of"
	einfo "these textures, e.g. qudos or quake2-icculus."
	echo
}
