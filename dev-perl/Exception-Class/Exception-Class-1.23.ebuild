# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Class/Exception-Class-1.23.ebuild,v 1.12 2008/11/18 14:53:32 tove Exp $

inherit perl-module

DESCRIPTION="Exception::Class module for perl"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Exception/${P}.readme"
IUSE="test"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
SRC_TEST="do"

DEPEND="${DEPEND}
	>=virtual/perl-Module-Build-0.28
	test? ( dev-perl/Test-Pod )
	dev-lang/perl"

RDEPEND=">=dev-perl/Class-Data-Inheritable-0.02
	>=dev-perl/Devel-StackTrace-1.12
	dev-lang/perl
	>=virtual/perl-Test-Simple-0.47"

export OPTIMIZE="$CFLAGS"

myconf='INSTALLDIRS=vendor'
