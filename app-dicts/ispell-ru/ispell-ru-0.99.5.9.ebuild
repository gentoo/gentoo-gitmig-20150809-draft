# Copyright 2002-2003 Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-ru/ispell-ru-0.99.5.9.ebuild,v 1.4 2003/08/06 06:48:30 vapier Exp $

MY_PV=${PV/.5./e}
S=${WORKDIR}
DESCRIPTION="Alexander I. Lebedev's Russian dictionary for ispell"
HOMEPAGE="http://fmg-www.cs.ucla.edu/geoff/ispell-dictionaries.html#Russian-dicts"
SRC_URI="ftp://scon155.phys.msu.su/pub/russian/ispell/rus-ispell-${MY_PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="ppc x86 sparc alpha mips hppa arm"

DEPEND="app-text/ispell"

src_compile() {
	make koi || die
}

src_install() {
	insinto /usr/lib/ispell
	doins russian.hash russian.aff
	exeinto /usr/lib/ispell-ru
	doexe sortkoi8 trans
	dodoc README README.koi LICENSE
}
