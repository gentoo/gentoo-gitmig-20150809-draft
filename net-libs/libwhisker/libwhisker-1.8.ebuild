# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libwhisker/libwhisker-1.8.ebuild,v 1.6 2004/03/29 14:53:05 mcummings Exp $

DESCRIPTION="Perl module geared to HTTP testing."
HOMEPAGE="http://www.wiretrip.net/rfp/"
SRC_URI="http://www.wiretrip.net/rfp/libwhisker/libwhisker-current.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="ssl"

DEPEND=">=dev-lang/perl-5.6.1
		ssl? ( >=dev-perl/Net-SSLeay-1.19 )"

RESTRICT="fetch"

pkg_nofetch() {
	einfo "Could not find the libwhisker tarball!"
	einfo "It could not be fetched normally because http://www.wiretrip.net "
	einfo "denies the wget User-Agent header."
	einfo "You can find this library in: "
	einfo ${SRC_URI}
}

src_compile() {
	cd ${S}
	perl Makefile.pl lib
}

src_install() {
	cd ${S}
	vendor_perl=`perl -e 'use Config; print $Config{installvendorlib}'`
	dodir ${vendor_perl}
	insinto ${vendor_perl}
	doins LW.pm
	dodoc docs/OPTIMIZE docs/evil.htm docs/whisker_hash.txt
	dodoc simple.pl api_demo.pl README
	perl scripts/func2html.pl LW.pm >> LW.html
	dohtml LW.html
}
