# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ConfigReader/ConfigReader-0.5.ebuild,v 1.10 2007/01/15 15:13:24 mcummings Exp $

# No sense in inheriting since this package is a flat set of files.
# No Makefile.PL/Build.PL to work with at all.
#inherit perl-module

DESCRIPTION="Read directives from a configuration file."
HOMEPAGE="http://search.cpan.org/~amw/"
SRC_URI="mirror://cpan/authors/id/A/AM/AMW/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

src_install() {
	eval `perl '-V:installvendorlib'`
	dodir ${installvendorlib}/${PN}
	cp ${S}/*.pm ${D}/${installvendorlib}/${PN}
	cp ${PN}.pod ${D}/${installvendorlib}
	dodoc README COPYING.LIB
}
