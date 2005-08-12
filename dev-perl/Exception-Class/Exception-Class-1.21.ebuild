# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Class/Exception-Class-1.21.ebuild,v 1.3 2005/08/12 08:39:11 mcummings Exp $

myconf='INSTALLDIRS=vendor'
inherit perl-module

DESCRIPTION="Exception::Class module for perl"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Exception/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~amd64 ~ppc ~sparc ~alpha"
SRC_TEST="do"

DEPEND="${DEPEND}
	dev-perl/module-build
	>=dev-perl/Class-Data-Inheritable-0.02
	>=dev-perl/Devel-StackTrace-1.11
	>=perl-core/Test-Simple-0.47"

export OPTIMIZE="$CFLAGS"
