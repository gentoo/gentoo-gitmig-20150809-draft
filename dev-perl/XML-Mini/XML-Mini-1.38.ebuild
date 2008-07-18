# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Mini/XML-Mini-1.38.ebuild,v 1.2 2008/07/18 18:50:49 armin76 Exp $

inherit perl-module

DESCRIPTION="pure perl API to create and parse XML"
HOMEPAGE="http://search.cpan.org/~pdeegan/"
SRC_URI="mirror://cpan/authors/id/P/PD/PDEEGAN/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 sparc x86"

DEPEND="dev-lang/perl"

SRC_TEST="do"
