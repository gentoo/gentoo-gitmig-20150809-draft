# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Class/Exception-Class-1.23.ebuild,v 1.7 2006/07/02 13:50:52 mcummings Exp $

myconf='INSTALLDIRS=vendor'
inherit perl-module

DESCRIPTION="Exception::Class module for perl"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Exception/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
SRC_TEST="do"

TDEPEND="dev-perl/Test-Pod"

DEPEND="${DEPEND}
	dev-perl/module-build"

RDEPEND=">=dev-perl/Class-Data-Inheritable-0.02
	>=dev-perl/Devel-StackTrace-1.12
	>=virtual/perl-Test-Simple-0.47"
export OPTIMIZE="$CFLAGS"
