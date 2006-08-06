# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mime-construct/mime-construct-1.9.ebuild,v 1.5 2006/08/06 02:50:24 mcummings Exp $

inherit perl-module

DESCRIPTION="construct and optionally mail MIME messages"
HOMEPAGE="http://search.cpan.org/~rosch/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RO/ROSCH/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/MIME-Types
	dev-perl/Proc-WaitStat
	dev-lang/perl"
RDEPEND="${DEPEND}"

