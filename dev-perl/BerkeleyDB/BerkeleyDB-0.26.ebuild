# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/BerkeleyDB/BerkeleyDB-0.26.ebuild,v 1.1 2004/10/21 12:37:39 mcummings Exp $

inherit perl-module eutils

DESCRIPTION="This module provides Berkeley DB interface for Perl."
HOMEPAGE="http://search.cpan.org/~pmqs/BerkeleyDB-0.25/"
SRC_URI="mirror://cpan/authors/id/P/PM/PMQS/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha"
IUSE=""

# Install DB_File if you want older support. BerkleyDB no longer
# supports less than 2.0.

DEPEND=">=sys-libs/db-2.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Gentoo-config-${PV}.diff
}
