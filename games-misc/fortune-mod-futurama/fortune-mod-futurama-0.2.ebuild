# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-futurama/fortune-mod-futurama-0.2.ebuild,v 1.1 2003/09/10 18:14:04 vapier Exp $

DESCRIPTION="Quotes from the TV-Series -Futurama-"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.gz"
HOMEPAGE="http://www.netmeister.org/misc.html"

KEYWORDS="x86 ppc alpha ~sparc ~mips"
SLOT="0"
LICENSE="as-is"

DEPEND="virtual/glibc"
RDEPEND="app-games/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins futurama futurama.dat
}
