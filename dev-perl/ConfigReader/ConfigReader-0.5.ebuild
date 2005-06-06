# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ConfigReader/ConfigReader-0.5.ebuild,v 1.1 2005/06/06 20:34:55 mcummings Exp $

# No sense in inheriting since this package is a flat set of files.
# No Makefile.PL/Build.PL to work with at all.
#inherit perl-module

DESCRIPTION="Read directives from a configuration file."
HOMEPAGE="http://search.cpan.org/~amw/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AM/AMW/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	fperms 444 *
}

src_install() {
	eval `perl '-V:installvendorlib'`
	VENDOR_LIB=${installvendorlib}
	dodir ${VENDOR_LIB}/${PN}
	cp ${S}/*.pm ${D}/${VENDOR_LIB}/${PN}
	cp ${PN}.pod ${D}/${VENDOR_LIB}
	dodoc README COPYING.LIB
}
