# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Server-Simple/HTTP-Server-Simple-0.27.ebuild,v 1.2 2007/04/09 15:23:55 mcummings Exp $

inherit perl-module

DESCRIPTION="Lightweight HTTP Server"
SRC_URI="mirror://cpan/authors/id/J/JE/JESSE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jesse/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
SRC_TEST="do"


DEPEND="dev-lang/perl"
