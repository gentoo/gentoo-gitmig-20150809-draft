# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tree-Simple/Tree-Simple-1.14.ebuild,v 1.4 2005/05/25 15:15:47 mcummings Exp $

# this is an RT dependency

inherit perl-module

DESCRIPTION="A simple tree object"
SRC_URI="mirror://cpan/authors/id/S/ST/STEVAN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~stevan/${P}/"

SRC_TEST="do"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~ppc sparc ~amd64"

DEPEND=">=perl-core/Test-Simple-0.47
	>=dev-perl/Test-Exception-0.15"
IUSE=""
