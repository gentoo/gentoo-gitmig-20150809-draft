# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MethodMaker/Class-MethodMaker-2.05.ebuild,v 1.1 2005/03/11 17:35:25 mcummings Exp $

inherit perl-module

MY_PV=${PV/4.1/4-1}
MY_P=${PN}-${MY_PV}
MY_SPV=${PV/.1/}
MY_SP=${PN}-${MY_SPV}

S="${WORKDIR}/${MY_SP}"

DESCRIPTION="Perl module for Class::MethodMaker"
HOMEPAGE="http://search.cpan.org/~fluffy/${MY_P}"
SRC_URI="mirror://cpan/authors/id/F/FL/FLUFFY/${MY_P}.tar.gz"


LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE=""

SRC_TEST="do"

# Despite including a Build script, this module dies in tests
# if built with it. Go figure.
#DEPEND="dev-perl/module-build"


