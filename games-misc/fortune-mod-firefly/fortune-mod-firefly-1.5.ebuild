# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-firefly/fortune-mod-firefly-1.5.ebuild,v 1.1 2005/10/03 22:31:10 wolf31o2 Exp $

DESCRIPTION="Quotes from FireFly"
HOMEPAGE="http://www.daughtersoftiresias.org/progs/firefly/"
SRC_URI="http://www.daughtersoftiresias.org/progs/firefly/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/fortune
	doins firefly firefly.dat
}
