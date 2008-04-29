# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/BerkeleyDB/BerkeleyDB-0.34.ebuild,v 1.1 2008/04/29 03:16:31 yuval Exp $

inherit perl-module eutils db-use

DESCRIPTION="This module provides Berkeley DB interface for Perl."
HOMEPAGE="http://search.cpan.org/~pmqs/BerkeleyDB"
SRC_URI="mirror://cpan/authors/id/P/PM/PMQS/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
SRC_TEST="do"

# Install DB_File if you want older support. BerkleyDB no longer
# supports less than 2.0.

DEPEND=">=sys-libs/db-2.0
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Gentoo-config-0.26.diff
	# on Gentoo/FreeBSD we cannot trust on the symlink /usr/include/db.h
	# as for Gentoo/Linux, so we need to esplicitely declare the exact berkdb
	# include path
	sed -i -e "s:/usr/include:$(db_includedir):" config.in || die "berkdb include directory"
}
