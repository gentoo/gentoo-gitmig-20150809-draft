# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-familyguy/fortune-mod-familyguy-0.2.ebuild,v 1.1 2006/10/12 15:03:05 nyhm Exp $

DESCRIPTION="Quotes from the TV-Series -Family Guy-"
HOMEPAGE="http://jon.oberheide.org/projects/familyguy/"
SRC_URI="http://jon.oberheide.org/projects/familyguy/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins familyguy familyguy.dat || die
}
