# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-gentoo-dev/fortune-mod-gentoo-dev-20030930.ebuild,v 1.1 2003/09/30 14:27:31 avenj Exp $

S=${WORKDIR}

DESCRIPTION="Fortune database of #gentoo-dev quotes"
SRC_URI="http://oppresses.us/~avenj/files/gentoo-dev-${PV}.gz"
HOMEPAGE="http://oppresses.us/~avenj/index.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips"

DEPEND="games-misc/fortune-mod"

src_compile () {
	mv gentoo-dev-${PV} gentoo-dev
	strfile gentoo-dev
}

src_install () {
	insinto /usr/share/fortune
	doins gentoo-dev gentoo-dev.dat
}

