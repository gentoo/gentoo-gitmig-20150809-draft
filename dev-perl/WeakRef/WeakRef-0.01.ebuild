# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WeakRef/WeakRef-0.01.ebuild,v 1.9 2005/08/26 00:35:53 agriffis Exp $

inherit perl-module

DESCRIPTION="an API to the Perl weak references"

HOMEPAGE="http://search.cpan.org/~lukka/${P}/"
SRC_URI="mirror://cpan/authors/id/L/LU/LUKKA/${P}.tar.gz"
SRC_TEST="do"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc sparc x86"
IUSE=""
