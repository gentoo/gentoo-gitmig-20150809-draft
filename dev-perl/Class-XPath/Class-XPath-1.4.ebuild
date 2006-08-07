# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-XPath/Class-XPath-1.4.ebuild,v 1.8 2006/08/07 00:26:48 mcummings Exp $

inherit perl-module

DESCRIPTION="adds xpath matching to object trees"
HOMEPAGE="http://search.cpan.org/~samtregar/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SA/SAMTREGAR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE="test"

SRC_TEST="do"

# HTML-Tree dep is for testing
DEPEND="test? ( dev-perl/HTML-Tree )
	dev-lang/perl"
RDEPEND="${DEPEND}"
