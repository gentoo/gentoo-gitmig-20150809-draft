# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-ru/ispell-ru-0.99.7.ebuild,v 1.1 2004/02/18 01:21:03 liquidx Exp $

MY_PV=$(echo ${PV} | sed 's/\.\([0-9]\)$/f\1/')
S="${WORKDIR}"
DESCRIPTION="Alexander I. Lebedev's Russian dictionary for ispell."
HOMEPAGE="http://fmg-www.cs.ucla.edu/geoff/ispell-dictionaries.html#Russian-dicts"
SRC_URI="ftp://scon155.phys.msu.su/pub/russian/ispell/rus-ispell-${MY_PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc ~x86 ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND="app-text/ispell"

src_compile() {
	make YO=1 || die
}

src_install () {
	insinto /usr/lib/ispell
	doins russian.hash russian.aff

	dodoc README README.koi LICENSE
}
