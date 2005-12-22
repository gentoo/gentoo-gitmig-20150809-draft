# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-gentoo-dev/fortune-mod-gentoo-dev-20051222.ebuild,v 1.1 2005/12/22 14:29:15 avenj Exp $

DESCRIPTION="Fortune database of #gentoo-dev quotes"
HOMEPAGE="http://oppresses.us/~avenj/index.html"
SRC_URI="http://oppresses.us/~avenj/files/gentoo-dev/gentoo-dev-${PV}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="games-misc/fortune-mod"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_compile () {
	mv gentoo-dev-${PV} gentoo-dev
	strfile gentoo-dev
}

src_install () {
	insinto /usr/share/fortune
	doins gentoo-dev gentoo-dev.dat
}
