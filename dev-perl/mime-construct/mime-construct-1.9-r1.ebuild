# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mime-construct/mime-construct-1.9-r1.ebuild,v 1.8 2007/01/19 14:07:33 mcummings Exp $

inherit perl-module

DESCRIPTION="construct and optionally mail MIME messages"
HOMEPAGE="http://search.cpan.org/~rosch/"
SRC_URI="mirror://cpan/authors/id/R/RO/ROSCH/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/MIME-Types
	dev-perl/Proc-WaitStat
	dev-lang/perl"
