# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-zx-error/fortune-mod-zx-error-1.0.ebuild,v 1.2 2004/06/24 22:56:53 agriffis Exp $

MY_P="fortunes-zx-error-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Sinclair ZX Spectrum BASIC error Fortunes"
HOMEPAGE="http://melkor.dnp.fmph.uniba.sk/~garabik/fortunes-zx-error.html"
SRC_URI="http://melkor.dnp.fmph.uniba.sk/~garabik/fortunes-zx-error/${MY_P}.tar.gz"

KEYWORDS="x86 ppc sparc mips alpha hppa amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="games-misc/fortune-mod"

src_install() {
	cp zx/error zx-error
	cp zx/error.dat zx-error.dat
	insinto /usr/share/fortune
	doins zx-error zx-error.dat
	dodoc README
}
