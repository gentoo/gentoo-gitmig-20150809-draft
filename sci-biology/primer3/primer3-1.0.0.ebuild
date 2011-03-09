# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/primer3/primer3-1.0.0.ebuild,v 1.16 2011/03/09 11:25:06 jlec Exp $

DESCRIPTION="Design primers for PCR reactions."
HOMEPAGE="http://primer3.sourceforge.net/"
SRC_URI="http://frodo.wi.mit.edu/${PN}/${PN}_${PV}.tar.gz"
LICENSE="whitehead"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND=""

DEPEND="dev-lang/perl"

S=${WORKDIR}/${PN}_${PV}/src

src_unpack() {
	unpack ${A}
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
