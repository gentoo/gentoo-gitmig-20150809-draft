# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Pod/Test-Pod-1.08.ebuild,v 1.1 2004/02/16 16:12:37 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"

DESCRIPTION="check for POD errors in files"
HOMEPAGE="http://search.cpan.org/~petdance/${P}"
SRC_URI="http://search.cpan.org/CPAN/authors/id/P/PE/PETDANCE/${P}.tar.gz"

SRC_TEST="do"
LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"
