# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/B-Keywords/B-Keywords-1.05.ebuild,v 1.2 2007/07/09 13:02:17 mcummings Exp $

inherit perl-module

DESCRIPTION="Lists of reserved barewords and symbol names"
HOMEPAGE="http://search.cpan.org/~jjore/"
SRC_URI="mirror://cpan/authors/id/J/JJ/JJORE/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
