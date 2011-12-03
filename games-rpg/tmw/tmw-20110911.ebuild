# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/tmw/tmw-20110911.ebuild,v 1.1 2011/12/03 18:38:16 tupone Exp $

EAPI=2
inherit eutils games

MY_PN=${PN}-branding
MY_P=${MY_PN}-${PV}

DESCRIPTION="Branding for the Mana client for server.themanaworld.org"
HOMEPAGE="http://themanaworld.org/"
SRC_URI="mirror://sourceforge/themanaworld/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="games-rpg/mana"
DEPEND=""

S="${WORKDIR}"/${MY_P}
PATCHES=( "${FILESDIR}"/${MY_PN}-gentoo.patch )

src_prepare() {
	base_src_prepare
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		tmw tmw.desktop \
		|| die "sed failed"
}

src_install() {
	doicon data/icons/tmw.xpm
	insinto /usr/share/icons
	doins data/icons/tmw.png
	dogamesbin tmw
	insinto "${GAMES_DATADIR}/${PN}/"
	doins tmw.mana
	doins -r data/
	insinto /usr/share/applications
	doins tmw.desktop
	prepgamesdirs
}
