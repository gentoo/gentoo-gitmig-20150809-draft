# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-smac/fortune-mod-smac-0.1.ebuild,v 1.9 2005/07/31 14:38:19 corsair Exp $

DESCRIPTION="Quotes from the Alpha Centauri: Alien Crossfire tech tree"
HOMEPAGE="http://homepages.ihug.com.au/~alana/"
SRC_URI="http://homepages.ihug.com.au/~alana/files/fortune-mod-smac/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins smac smac.dat
}
