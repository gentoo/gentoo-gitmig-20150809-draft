# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBI-Shell/DBI-Shell-11.93.ebuild,v 1.2 2005/07/24 17:28:17 dholm Exp $

inherit perl-module

DESCRIPTION="Interactive command shell for the DBI"
HOMEPAGE="http://search.cpan.org/~tlowery/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TL/TLOWERY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/IO-Tee
		dev-perl/Text-Reform"
