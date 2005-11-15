# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-firefly/fortune-mod-firefly-2.0.ebuild,v 1.1 2005/11/15 00:10:26 vapier Exp $

DESCRIPTION="Quotes from FireFly"
HOMEPAGE="http://www.daughtersoftiresias.org/progs/firefly/"
SRC_URI="http://www.daughtersoftiresias.org/progs/firefly/${P/mod-}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}

src_install() {
	insinto /usr/share/fortune
	doins firefly firefly.dat || die
}
