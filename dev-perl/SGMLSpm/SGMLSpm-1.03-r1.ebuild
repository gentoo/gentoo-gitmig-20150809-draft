# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SGMLSpm/SGMLSpm-1.03-r1.ebuild,v 1.3 2002/07/25 04:13:27 seemant Exp $

MY_P="${P}ii"
S=${WORKDIR}/${PN}
DESCRIPTION="Perl library for parsing the output of nsgmls"
SRC_URI="http://cpan.perl.org/pub/perl/CPAN/modules/by-module/SGMLS/${MY_P}.tar.gz"
SLOT="0"
HOMEPAGE="http://cpan.perl.org/pub/perl/CPAN/modules/by-module/SGMLS/${MY_P}.readme"
SLOT="0"
LICENSE="GPL-2"

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
	make || die
	cd ${D}/usr/lib/${package}
	mv SGMLS.pm site_perl/${version}/SGMLS.pm

	dodoc BUGS COPYING ChangeLog README TODO

}
