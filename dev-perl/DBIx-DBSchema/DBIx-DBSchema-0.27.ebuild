# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-DBSchema/DBIx-DBSchema-0.27.ebuild,v 1.1 2005/11/13 14:53:12 mcummings Exp $

inherit perl-module

DESCRIPTION="Database-independent schema objects"
HOMEPAGE="http://search.cpan.org/~ivan/${P}/"
SRC_URI="mirror://cpan/authors/id/I/IV/IVAN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/DBI
		dev-perl/FreezeThaw"
