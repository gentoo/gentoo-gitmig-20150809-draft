# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Class/Exception-Class-1.19.ebuild,v 1.6 2005/05/25 15:07:03 mcummings Exp $

myconf='INSTALLDIRS=vendor'
inherit perl-module

DESCRIPTION="Exception::Class module for perl"
SRC_URI="http://www.cpan.org/modules/by-module/Exception/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Exception/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ppc ~sparc ~alpha"
SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-perl/Class-Data-Inheritable-0.02
	>=dev-perl/Devel-StackTrace-1.11
	>=perl-core/Test-Simple-0.47"

export OPTIMIZE="$CFLAGS"
