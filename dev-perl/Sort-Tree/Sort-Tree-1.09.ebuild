# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sort-Tree/Sort-Tree-1.09.ebuild,v 1.8 2007/01/19 15:48:16 mcummings Exp $

inherit perl-module
SRC_TEST="do"

DESCRIPTION="Organize list of objects into parent/child order."
HOMEPAGE="http://search.cpan.org/~bryce/"
SRC_URI="mirror://cpan/authors/id/B/BR/BRYCE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 x86"
IUSE=""

DEPEND="dev-lang/perl"
