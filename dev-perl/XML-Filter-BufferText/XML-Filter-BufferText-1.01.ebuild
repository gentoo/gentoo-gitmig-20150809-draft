# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Filter-BufferText/XML-Filter-BufferText-1.01.ebuild,v 1.8 2005/01/12 23:18:06 gustavoz Exp $

inherit perl-module

DESCRIPTION="Filter to put all characters() in one event"
SRC_URI="http://search.cpan.org/CPAN/authors/id/R/RB/RBERJON/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rberjon/${P}"

SRC_TEST="do"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc sparc alpha ~mips"
IUSE=""

DEPEND="${DEPEND}
		dev-perl/XML-SAX-Base
		>=dev-perl/XML-SAX-0.12"
