# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBI-Shell/DBI-Shell-11.95.ebuild,v 1.1 2008/12/08 02:13:42 robbat2 Exp $

inherit perl-module

DESCRIPTION="Interactive command shell for the DBI"
HOMEPAGE="http://search.cpan.org/~tlowery/"
SRC_URI="mirror://cpan/authors/id/T/TL/TLOWERY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/IO-Tee
	dev-perl/text-reform
	dev-lang/perl"
