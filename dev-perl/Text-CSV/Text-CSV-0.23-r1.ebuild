# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CSV/Text-CSV-0.23-r1.ebuild,v 1.5 2003/06/21 21:36:37 drobbins Exp $

inherit perl-module

MY_P=Text-CSV_XS-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Comma-separated value text processing for Perl"
SRC_URI="http://www.cpan.org/modules/by-module/Text/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Text/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
