# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-ru/ispell-ru-0.99.6.1.ebuild,v 1.11 2004/11/24 20:51:30 swegener Exp $

MY_PV=${PV/.6./f}
S="${WORKDIR}"
DESCRIPTION="Alexander I. Lebedev's Russian dictionary for ispell."
HOMEPAGE="http://fmg-www.cs.ucla.edu/geoff/ispell-dictionaries.html#Russian-dicts"
SRC_URI="mirror://gentoo/rus-ispell-${MY_PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
IUSE=""
KEYWORDS="ppc x86 sparc ~alpha mips hppa"

DEPEND="app-text/ispell"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/ispell
	doins russian.hash russian.aff

	dodoc README README.koi LICENSE
}
