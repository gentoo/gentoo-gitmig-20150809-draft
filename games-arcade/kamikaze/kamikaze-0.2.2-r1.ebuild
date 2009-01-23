# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/kamikaze/kamikaze-0.2.2-r1.ebuild,v 1.5 2009/01/23 08:53:43 tupone Exp $

inherit kde

DESCRIPTION="A bomberman like game for KDE"
HOMEPAGE="http://kamikaze.coolprojects.org/"
SRC_URI="http://kamikaze.coolprojects.org/download/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~sparc x86"
SLOT="0"
IUSE=""

DEPEND=">=dev-games/ggz-client-libs-0.0.13"

need-kde 3

src_unpack() {
	kde_src_unpack
	sed -i \
		-e "s:-isystem:-idirafter:g" \
		configure \
		|| die "sed failed"
}
