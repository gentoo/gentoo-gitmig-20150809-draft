# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/quake4-sdk/quake4-sdk-1.3.ebuild,v 1.2 2006/10/09 11:19:52 nyhm Exp $

inherit eutils games

MY_P="quake4-linux-${PV}-sdk"
DESCRIPTION="Quake4 SDK"
HOMEPAGE="http://www.iddevnet.com/quake4/"
SRC_URI="http://sonic-lux.net/data/mirror/quake4/${MY_P}.x86.run"

LICENSE="QUAKE4"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="strip"

S=${WORKDIR}

src_unpack() {
	unpack_makeself
	rm -rf setup.{sh,data} || die
}

src_install() {
	insinto "${GAMES_PREFIX_OPT}/${PN}"
	doins -r * || die
	prepgamesdirs
}
