# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MethodMaker/Class-MethodMaker-2.05.ebuild,v 1.2 2005/03/14 18:22:49 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl module for Class::MethodMaker"
HOMEPAGE="http://search.cpan.org/~fluffy/${MY_P}"
SRC_URI="mirror://cpan/authors/id/F/FL/FLUFFY/${P}.tar.gz"
#style="builder"


LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE=""

SRC_TEST="do"

# Despite including a Build script, this module dies in tests
# if built with it. Go figure.
#DEPEND="dev-perl/module-build"

src_unpack() {
	# This sad little hack is to accomadate a change in the eclass to 
	# handle module-build modules more smoothly - except that the 
	# Build.PL for this module is currently broken.
	unpack ${A}
	if [ -f ${S}/Build.PL ]; then
		rm ${S}/Build.PL
	fi
}
