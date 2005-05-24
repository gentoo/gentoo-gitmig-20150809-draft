# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event/Event-1.00.ebuild,v 1.9 2005/05/24 17:49:17 mcummings Exp $

inherit perl-module

CATEGORY="dev-perl"
DESCRIPTION="fast, generic event loop"
SRC_URI="mirror://cpan/authors/id/J/JP/JPRIT/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Event/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ~ppc sparc ~alpha"
IUSE=""
SRC_TEST="do"
DEPEND="perl-core/Test"

mydoc="ANNOUNCE INSTALL TODO Tutorial.pdf"
