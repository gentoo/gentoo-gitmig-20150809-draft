# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CDDB-File/CDDB-File-1.03.ebuild,v 1.3 2002/09/21 01:05:14 vapier Exp $

inherit perl-module

S="${WORKDIR}/${P}"
DESCRIPTION="Parse a CDDB/freedb data file"
SRC_URI="http://search.cpan.org/CPAN/authors/id/T/TM/TMTM/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://search.cpan.org/author/TMTM/CDDB-File-${PV}/"
DEPEND="${DEPEND}
	dev-perl/Test-Simple"

SLOT="2"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc"
