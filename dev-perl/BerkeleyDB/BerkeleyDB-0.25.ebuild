# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/BerkeleyDB/BerkeleyDB-0.25.ebuild,v 1.3 2004/06/16 14:23:22 ciaranm Exp $

inherit perl-module eutils

DESCRIPTION="This module provides Berkeley DB interface for Perl."
HOMEPAGE="http://search.cpan.org/~pmqs/BerkeleyDB-0.25/"
SRC_URI="http://www.cpan.org/modules/by-module/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

# this will work with older versions of BerkeleyDB too, but I'm in
# no position to provide support for people who need that

DEPEND=">=sys-libs/db-2.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Gentoo-config.diff
}
