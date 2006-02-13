# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CDDB-File/CDDB-File-1.03-r1.ebuild,v 1.12 2006/02/13 10:43:55 mcummings Exp $

inherit perl-module

DESCRIPTION="Parse a CDDB/freedb data file"
SRC_URI="mirror://cpan/authors/id/T/TM/TMTM/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://search.cpan.org/~tmtm/${P}/"
DEPEND="${DEPEND}
	virtual/perl-Test-Simple"

LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc x86"
IUSE=""
