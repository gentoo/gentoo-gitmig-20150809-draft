# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-ISO/Date-ISO-1.28.ebuild,v 1.16 2005/04/02 21:40:59 hansmi Exp $

inherit perl-module

MY_P=Date-ISO-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Date::ICal subclass that handles ISO format dates"
SRC_URI="http://www.cpan.org/modules/by-module/Date/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Date/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="dev-perl/Date-ICal
	dev-perl/Memoize"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
