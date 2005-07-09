# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WeakRef/WeakRef-0.01.ebuild,v 1.8 2005/07/09 23:08:59 swegener Exp $

inherit perl-module

DESCRIPTION="an API to the Perl weak references"

HOMEPAGE="http://search.cpan.org/~lukka/${P}/"
SRC_URI="mirror://cpan/authors/id/L/LU/LUKKA/${P}.tar.gz"
SRC_TEST="do"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc ~alpha"
IUSE=""
