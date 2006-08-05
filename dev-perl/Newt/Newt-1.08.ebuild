# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Newt/Newt-1.08.ebuild,v 1.4 2006/08/05 19:36:50 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl bindings for RedHat newt library"
HOMEPAGE="http://search.cpan.org/~amedina/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AM/AMEDINA/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

# Disabled all together since the tests are interactive
#SRC_TEST="do"

DEPEND="<sys-libs/slang-2
	dev-lang/perl"
RDEPEND="${DEPEND}"


