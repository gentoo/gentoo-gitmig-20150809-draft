# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-zx-error/fortune-mod-zx-error-1.0.ebuild,v 1.8 2010/10/08 03:59:33 leio Exp $

MY_P="fortunes-zx-error-${PV}"
DESCRIPTION="Sinclair ZX Spectrum BASIC error Fortunes"
HOMEPAGE="http://korpus.juls.savba.sk/~garabik/software/fortunes-zx-error.html"
SRC_URI="http://korpus.juls.savba.sk/~garabik/software/fortunes-zx-error/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${MY_P}

src_install() {
	insinto /usr/share/fortune
	newins zx/error zx-error || die
	newins zx/error.dat zx-error.dat || die
	dodoc README
}
