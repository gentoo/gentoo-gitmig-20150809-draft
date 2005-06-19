# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/primer3/primer3-1.0.0.ebuild,v 1.7 2005/06/19 19:40:21 corsair Exp $

DESCRIPTION="Design primers for PCR reactions."
HOMEPAGE="http://frodo.wi.mit.edu/primer3/primer3_code.html"
SRC_URI="http://frodo.wi.mit.edu/${PN}/${PN}_${PV}.tar.gz"
LICENSE="whitehead"

SLOT="0"
KEYWORDS="ppc ppc-macos ppc64 x86"
IUSE=""

RDEPEND=""

DEPEND="dev-lang/perl"

S=${WORKDIR}/${PN}_${PV}/src

src_unpack() {
	unpack ${A}
	if use ppc-macos; then
		cd ${S}
		sed -e "s:LIBOPTS ='-static':LIBOPTS =:" -i Makefile || die
	fi
}

src_compile() {
	emake -e || die
}

src_test () {
	cd ../test
	perl primer_test.pl primer3_core || die
}

src_install () {
	dobin primer3_core
	dodoc release_notes ../README ../example
}
