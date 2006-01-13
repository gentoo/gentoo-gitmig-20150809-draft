# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MethodMaker/Class-MethodMaker-2.07-r2.ebuild,v 1.2 2006/01/13 13:35:27 mcummings Exp $

inherit perl-module eutils

DESCRIPTION="Perl module for Class::MethodMaker"
HOMEPAGE="http://search.cpan.org/~fluffy/${MY_P}"
SRC_URI="mirror://cpan/authors/id/F/FL/FLUFFY/${P}.tar.gz"


LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE=""

SRC_TEST="do"
#USE_BUILDER="no"


DEPEND="dev-perl/module-build"
