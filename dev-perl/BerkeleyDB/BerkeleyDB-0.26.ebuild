# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/BerkeleyDB/BerkeleyDB-0.26.ebuild,v 1.11 2006/07/03 20:23:30 ian Exp $

inherit perl-module eutils

DESCRIPTION="This module provides Berkeley DB interface for Perl."
HOMEPAGE="http://search.cpan.org/~pmqs/${P}"
SRC_URI="mirror://cpan/authors/id/P/PM/PMQS/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

# Install DB_File if you want older support. BerkleyDB no longer
# supports less than 2.0.

DEPEND=">=sys-libs/db-2.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Gentoo-config-${PV}.diff
}
