# Copyright 2002-2003 Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-ru/ispell-ru-0.99.5.9.ebuild,v 1.3 2003/03/08 01:07:44 vladimir Exp $

MY_PV=${PV/.5./e}
S=${WORKDIR}
DESCRIPTION="Alexander I. Lebedev's Russian dictionary for ispell."
HOMEPAGE="http://fmg-www.cs.ucla.edu/geoff/ispell-dictionaries.html#Russian-dicts"
SRC_URI="ftp://scon155.phys.msu.su/pub/russian/ispell/rus-ispell-${MY_PV}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="ppc x86 sparc alpha mips hppa arm"

DEPEND="app-text/ispell"

src_compile() {
    make koi || die
}

src_install () {
    insinto /usr/lib/ispell
    doins russian.hash russian.aff
    exeinto /usr/lib/ispell-ru
    doexe sortkoi8 trans
    dodoc README README.koi LICENSE
}
