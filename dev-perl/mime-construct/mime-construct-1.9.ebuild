# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mime-construct/mime-construct-1.9.ebuild,v 1.1 2005/05/19 09:26:39 mcummings Exp $

inherit perl-module

DESCRIPTION="construct and optionally mail MIME messages"
HOMEPAGE="http://search.cpan.org/~rosch/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RO/ROSCH/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Proc-WaitStat"
