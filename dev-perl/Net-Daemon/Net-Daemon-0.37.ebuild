# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Daemon/Net-Daemon-0.37.ebuild,v 1.17 2006/08/05 14:12:29 mcummings Exp $

inherit perl-module

DESCRIPTION="Abstract base class for portable servers"
HOMEPAGE="http://www.cpan.org/modules/by-module/Net/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/Net/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 s390 ppc64"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
