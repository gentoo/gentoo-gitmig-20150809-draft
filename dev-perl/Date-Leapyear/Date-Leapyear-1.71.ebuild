# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Leapyear/Date-Leapyear-1.71.ebuild,v 1.8 2004/10/16 23:57:21 rac Exp $

inherit perl-module

MY_P=Date-Leapyear-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Simple Perl module that tracks Gregorian leap years"
SRC_URI="http://www.cpan.org/modules/by-module/Date/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Date/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ~ppc sparc alpha"
IUSE=""

DEPEND="dev-perl/Test-Simple
		dev-perl/Test-Harness"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
