# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-XPath/Class-XPath-1.4.ebuild,v 1.1 2005/02/07 10:12:43 mcummings Exp $

inherit perl-module

DESCRIPTION="adds xpath matching to object trees"
HOMEPAGE="http://search.cpan.org/~samtregar/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SA/SAMTREGAR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

# HTML-Tree dep is for testing
DEPEND="dev-perl/HTML-Tree"
