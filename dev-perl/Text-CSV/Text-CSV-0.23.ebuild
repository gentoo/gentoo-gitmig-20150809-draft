# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CSV/Text-CSV-0.23.ebuild,v 1.3 2002/07/25 04:13:27 seemant Exp $

inherit perl-module

MY_P=Text-CSV_XS-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Comma-separated value text processing for Perl"
LICENSE="Artistic | GPL-2"
SRC_URI="http://www.cpan.org/modules/by-module/Text/${MY_P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/Text/${MY_P}.readme"
SLOT="0"

src_compile() {
	base_src_compile
	base_src_test || die "test failed"
}
