# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-homer/fortune-mod-homer-0.1.ebuild,v 1.2 2003/09/10 18:39:26 vapier Exp $

S=${WORKDIR}/${PN/mod-/}
DESCRIPTION="Quotes from Homer Simpson"
SRC_URI="http://www.cs.indiana.edu/~crcarter/homer/homer-quotes.tar.gz"
HOMEPAGE="http://www.cs.indiana.edu/~crcarter/homer/homer.html"

SLOT="0"
KEYWORDS="x86 ppc ~sparc ~mips"
LICENSE="GPL-2"

DEPEND="virtual/glibc"
RDEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins homer homer.dat
}
