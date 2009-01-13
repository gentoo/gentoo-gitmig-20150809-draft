# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/kbilliards/kbilliards-0.8.7b.ebuild,v 1.4 2009/01/13 15:33:43 tupone Exp $

ARTS_REQUIRED=yes
inherit eutils kde

DESCRIPTION="a funny billiards simulator game, under KDE"
HOMEPAGE="http://www.hostnotfound.it/kbilliards.php"
SRC_URI="http://www.hostnotfound.it/kbilliards/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

need-kde 3

src_unpack() {
	base_src_unpack
	epatch "${FILESDIR}"/${P}-gcc43.patch
	kde_sandbox_patch "${S}"/media/{balls,maps,other,sound}
}
