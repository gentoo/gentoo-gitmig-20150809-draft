# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Cache/Cache-Cache-1.04.ebuild,v 1.3 2005/08/26 02:12:47 agriffis Exp $

inherit perl-module

DESCRIPTION="Generic cache interface and implementations"
SRC_URI="mirror://cpan/authors/id/D/DC/DCLINTON/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/D/DC/DCLINTON/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-perl/Digest-SHA1-2.02
	>=dev-perl/Error-0.15
	>=perl-core/Storable-1.0.14
	>=dev-perl/IPC-ShareLite-0.09"

export OPTIMIZE="$CFLAGS"
