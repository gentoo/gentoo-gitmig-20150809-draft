# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libwhisker/libwhisker-2.2.ebuild,v 1.3 2005/03/13 20:38:32 mcummings Exp $

MY_P="${PN}2-current"
S="${WORKDIR}/${PN}2-${PV}"
DESCRIPTION="Perl module geared to HTTP testing."
HOMEPAGE="http://www.wiretrip.net/rfp/"
SRC_URI="http://www.wiretrip.net/rfp/libwhisker/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc"
IUSE="ssl"

DEPEND=">=dev-lang/perl-5.6.1
		ssl? ( >=dev-perl/Net-SSLeay-1.19 )"

src_compile() {
	cd ${S}
	perl Makefile.pl lib
}

src_install() {
	cd ${S}
	vendor_perl=`perl -e 'use Config; print $Config{installvendorlib}'`
	dodir ${vendor_perl}
	insinto ${vendor_perl}
	doins LW2.pm
	dodoc docs/* scripts/*
	dohtml LW.html
}
