# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Filter-BufferText/XML-Filter-BufferText-1.01.ebuild,v 1.1 2004/02/16 16:26:03 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="SAX2 Writer"
SRC_URI="http://search.cpan.org/CPAN/authors/id/R/RB/RBERJON/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rberjon/${P}"

SRC_TEST="do"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~amd64 ~ppc ~sparc ~alpha ~mips"

DEPEND="${DEPEND}
		>=dev-perl/XML-SAX-0.12"

