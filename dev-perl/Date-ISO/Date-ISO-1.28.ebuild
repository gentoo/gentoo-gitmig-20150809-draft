# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-ISO/Date-ISO-1.28.ebuild,v 1.1 2002/06/28 17:51:48 seemant Exp $

inherit perl-module

MY_P=Date-ISO-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Date::ICal subclass that handles ISO format dates"
LICENSE="Artistic | GPL-2"
SRC_URI="http://www.cpan.org/modules/by-module/Date/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Date/${MY_P}.readme"
SLOT="0"

newdepend "dev-perl/Date-ICal
	dev-perl/Memoize"

src_compile() {
	base_src_compile
	base_src_test || die "test failed"
}
