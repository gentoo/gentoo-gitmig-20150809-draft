# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-homer/fortune-mod-homer-0.1.ebuild,v 1.8 2005/07/31 14:29:34 corsair Exp $

DESCRIPTION="Quotes from Homer Simpson"
HOMEPAGE="http://www.cs.indiana.edu/~crcarter/homer/homer.html"
SRC_URI="http://www.cs.indiana.edu/~crcarter/homer/homer-quotes.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S="${WORKDIR}/${PN/mod-/}"

src_install() {
	insinto /usr/share/fortune
	doins homer homer.dat
}
