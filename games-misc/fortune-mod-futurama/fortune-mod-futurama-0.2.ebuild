# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-futurama/fortune-mod-futurama-0.2.ebuild,v 1.6 2004/05/04 00:21:18 mr_bones_ Exp $

DESCRIPTION="Quotes from the TV-Series -Futurama-"
HOMEPAGE="http://www.netmeister.org/misc.html"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"
IUSE=""

RDEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins futurama futurama.dat
}
