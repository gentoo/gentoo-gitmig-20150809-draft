# Copyright 2002 Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ispell-ru/ispell-ru-0.99.5.9.ebuild,v 1.2 2002/07/11 06:30:15 drobbins Exp $

DESCRIPTION="Alexander I. Lebedev's Russian dictionary for ispell."
HOMEPAGE="http://fmg-www.cs.ucla.edu/geoff/ispell-dictionaries.html#Russian-dicts"

DEPEND="app-text/ispell"

# Note: Portage versioning brain damage
# The package name such as 0.99e9 cannot be used.
# Workaround: replace the alphabetic component by a number.  I.e. "e" becomes ".5.".
RUS_ISPELL_V=0.99e9

SRC_URI="ftp://scon155.phys.msu.su/pub/russian/ispell/rus-ispell-${RUS_ISPELL_V}.tar.gz"
S="${WORKDIR}"

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
