# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-smac/fortune-mod-smac-0.1.ebuild,v 1.3 2003/09/16 15:18:35 dholm Exp $

DESCRIPTION="Quotes from the Alpha Centauri: Alien Crossfire tech tree"
SRC_URI="http://homepages.ihug.com.au/~alana/files/fortune-mod-smac/${P}.tar.gz"
HOMEPAGE="http://homepages.ihug.com.au/~alana/"

KEYWORDS="x86 ~sparc ~mips ~ppc"
SLOT="0"
LICENSE="as-is"

DEPEND="virtual/glibc"
RDEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins smac smac.dat
}
