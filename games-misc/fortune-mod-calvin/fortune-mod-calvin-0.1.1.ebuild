# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-calvin/fortune-mod-calvin-0.1.1.ebuild,v 1.1 2003/09/10 18:14:04 vapier Exp $

DESCRIPTION="Quotes from Calvin and Hobbes Comic Books"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.gz"
HOMEPAGE="http://www.netmeister.org/misc.html"

KEYWORDS="x86 ppc ~sparc ~mips"
SLOT="0"
LICENSE="as-is"

DEPEND="virtual/glibc"
RDEPEND="app-games/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins calvin calvin.dat
}
