# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Leapyear/Date-Leapyear-1.7.ebuild,v 1.1 2002/06/28 12:31:33 seemant Exp $

inherit perl-module

MY_P=Date-Leapyear-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Simple Perl module that tracks Gregorian leap years"
LICENSE="Artistic | GPL-2"
SRC_URI="http://www.cpan.org/modules/by-module/Date/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Date/${MY_P}.readme"

SLOT="0"

newdepend "dev-perl/Test-Simple"

src_compile() {
	base_src_compile
	base_src_test || die "test failed"
}
