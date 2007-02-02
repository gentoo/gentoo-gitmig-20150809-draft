# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/primer3/primer3-1.0.1.ebuild,v 1.1 2007/02/02 15:19:41 ribosome Exp $

DESCRIPTION="Design primers for PCR reactions."
HOMEPAGE="http://frodo.wi.mit.edu/primer3/primer3_code.html"
SRC_URI="http://frodo.wi.mit.edu/${PN}/${PN}_${PV}.tar.gz"
LICENSE="whitehead"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

RDEPEND=""

S="${WORKDIR}/${PN}_${PV}/src"

src_compile() {
	emake -e || die
}

src_test () {
	cd ../test
	perl primer_test.pl primer3_core || die
}

src_install () {
	dobin primer3_core || die "Could not install program."
	dodoc ../{how-to-cite.txt,README.${PN}_${PV}.txt,example} || \
			die "Could not install documentation."
}
