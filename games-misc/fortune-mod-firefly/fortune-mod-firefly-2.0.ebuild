# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-firefly/fortune-mod-firefly-2.0.ebuild,v 1.2 2006/07/17 04:57:58 vapier Exp $

DESCRIPTION="Quotes from FireFly"
HOMEPAGE="http://www.daughtersoftiresias.org/progs/firefly/"
SRC_URI="http://www.daughtersoftiresias.org/progs/firefly/${P/mod-}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}

src_install() {
	insinto /usr/share/fortune
	doins firefly firefly.dat || die
}
