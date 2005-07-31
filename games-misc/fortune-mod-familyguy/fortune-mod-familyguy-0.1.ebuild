# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-familyguy/fortune-mod-familyguy-0.1.ebuild,v 1.2 2005/07/31 14:24:55 corsair Exp $

DESCRIPTION="Quotes from the TV-Series -Family Guy-"
HOMEPAGE="http://jon.oberheide.org/projects/familyguy/"
SRC_URI="http://jon.oberheide.org/projects/familyguy/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins familyguy familyguy.dat
}
