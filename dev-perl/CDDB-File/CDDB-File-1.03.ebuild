# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CDDB-File/CDDB-File-1.03.ebuild,v 1.11 2004/10/16 23:57:20 rac Exp $

inherit perl-module

DESCRIPTION="Parse a CDDB/freedb data file"
SRC_URI="http://search.cpan.org/CPAN/authors/id/T/TM/TMTM/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://search.cpan.org/author/TMTM/CDDB-File-${PV}/"
DEPEND="${DEPEND}
	dev-perl/Test-Simple"

LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc alpha"
IUSE=""
