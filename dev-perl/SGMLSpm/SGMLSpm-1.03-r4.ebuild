# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SGMLSpm/SGMLSpm-1.03-r4.ebuild,v 1.13 2004/07/14 20:23:53 agriffis Exp $

MY_P="${P}ii"
S=${WORKDIR}/${PN}
DESCRIPTION="Perl library for parsing the output of nsgmls"
SRC_URI="http://search.cpan.org/CPAN/authors/id/D/DM/DMEGG/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/DMEGG/SGMLSpm-1.03ii/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 sparc alpha ppc hppa ia64"
IUSE=""

src_unpack() {

	unpack ${A}
	cp ${FILESDIR}/${P}-Makefile ${S}/Makefile

}

src_install () {

	eval `perl '-V:package'`
	eval `perl '-V:version'`
	cd ${S}
	dodir /usr/lib/${package}/site_perl/${version}
	dodir /usr/bin
	cp Makefile Makefile.bak
	sed -e "s:5.6.1:${version}:" Makefile.bak > Makefile
	cp Makefile Makefile.bak
	sed -e "s:perl5:perl5/site_perl/${version}:" Makefile.bak > Makefile
	cp Makefile Makefile.bak
	sed -e "s:MODULEDIR = \${PERL5DIR}/site_perl/${version}/SGMLS:MODULEDIR = \${PERL5DIR}/SGMLS:" Makefile.bak > Makefile
	make -f Makefile || die
	cd ${D}/usr/lib/${package}/site_perl/${version}
	#mv SGMLS.pm site_perl/${version}/SGMLS.pm

	dodoc BUGS COPYING ChangeLog README TODO

}
