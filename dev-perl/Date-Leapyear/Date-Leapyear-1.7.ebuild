# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Leapyear/Date-Leapyear-1.7.ebuild,v 1.3 2002/07/27 18:27:15 aliz Exp $

inherit perl-module

MY_P=Date-Leapyear-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Simple Perl module that tracks Gregorian leap years"
SRC_URI="http://www.cpan.org/modules/by-module/Date/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Date/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"

newdepend "dev-perl/Test-Simple"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
