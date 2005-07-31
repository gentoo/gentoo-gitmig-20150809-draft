# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-debilneho/fortune-mod-debilneho-0.1.ebuild,v 1.5 2005/07/31 14:22:46 corsair Exp $

MY_PN=${PN/mod-/}
DESCRIPTION="Quotation's by several people (mostly from Slovakia)"
HOMEPAGE="http://megac.info"
SRC_URI="http://megac.info/fortune-debilneho.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S="${WORKDIR}/${MY_PN}"

src_install() {
	insinto /usr/share/fortune
	doins debilneho debilneho.dat
}
