# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-calvin/fortune-mod-calvin-0.1.1.ebuild,v 1.3 2003/10/15 20:20:57 vapier Exp $

DESCRIPTION="Quotes from Calvin and Hobbes Comic Books"
HOMEPAGE="http://www.netmeister.org/misc.html"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips"

RDEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins calvin calvin.dat
}
