# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-rss/fortune-mod-rss-20030120.ebuild,v 1.3 2004/10/18 22:24:24 kloeri Exp $

DESCRIPTION="Fortune database of Robin S. Socha quotes"
HOMEPAGE="http://fortune-mod-fvl.sourceforge.net/"
SRC_URI="mirror://sourceforge/fortune-mod-fvl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 hppa alpha"
IUSE=""

RDEPEND="games-misc/fortune-mod"

src_install () {
	insinto /usr/share/fortune
	doins rss rss.dat
}
