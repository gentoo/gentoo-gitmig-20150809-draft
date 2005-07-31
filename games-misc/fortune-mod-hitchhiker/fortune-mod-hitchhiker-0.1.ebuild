# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-hitchhiker/fortune-mod-hitchhiker-0.1.ebuild,v 1.8 2005/07/31 14:28:55 corsair Exp $

MY_P=${PN/-mod/}
DESCRIPTION="Quotes from Hitchhikers Guide to the Galaxy"
HOMEPAGE="http://www.splitbrain.org/index.php?x=.%2FFortunes%2Fhitchhiker"
SRC_URI="http://www.splitbrain.org/Fortunes/hitchhiker/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto /usr/share/fortune
	doins hitchhiker hitchhiker.dat
}
