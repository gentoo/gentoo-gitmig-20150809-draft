# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MakeMethods-Template/Class-MakeMethods-Template-1.004.ebuild,v 1.1 2002/06/28 12:27:14 seemant Exp $

inherit perl-module

MY_P=Class-MakeMethods-Template-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Extensible temlpates for Class::MakeMethods"
LICENSE="Artistic | GPL-2"
SRC_URI="http://www.cpan.org/modules/by-module/Class/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Class/${MY_P}.readme"
SLOT="0"
 
newdepend ">=Class-MakeMethods-1.003"

src_compile() {
	base_src_compile
	base_src_test || die "test failed"
}
