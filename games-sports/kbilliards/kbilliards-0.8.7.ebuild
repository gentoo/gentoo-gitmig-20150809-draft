# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/kbilliards/kbilliards-0.8.7.ebuild,v 1.2 2006/10/05 09:27:52 blubb Exp $

ARTS_REQUIRED=yes
inherit kde

DESCRIPTION="a funny billiards simulator game, under KDE"
HOMEPAGE="http://www.hostnotfound.it/kbilliards.php"
SRC_URI="http://www.hostnotfound.it/kbilliards/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

need-kde 3

src_unpack() {
	base_src_unpack
	kde_sandbox_patch "${S}"/media/{balls,maps,other,sound}
}
