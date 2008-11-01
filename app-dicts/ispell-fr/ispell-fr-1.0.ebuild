# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-fr/ispell-fr-1.0.ebuild,v 1.14 2008/11/01 09:18:56 pva Exp $

MY_P="Francais-GUTenberg-v${PV}"
DESCRIPTION="French dictionnary for ispell"
HOMEPAGE="http://www.unil.ch/ling/cp/frgut.html"
SRC_URI="http://www.unil.ch/ling/cp/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="alpha amd64 hppa ~mips ppc sparc x86"

DEPEND="app-text/ispell"

S=${WORKDIR}/${MY_P}

src_compile() {
	cat dicos/*.dico | sort > francais.dico
	buildhash francais.dico francais.aff francais.hash || die
	buildhash francais.dico francais-TeX8b.aff francais-TeX8b.hash || die
}

src_install () {
	insinto /usr/lib/ispell
	doins francais.aff francais.hash francais-TeX8b.aff francais-TeX8b.hash || die
}
