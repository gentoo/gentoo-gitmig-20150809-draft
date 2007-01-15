# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Server-Simple/HTTP-Server-Simple-0.16.ebuild,v 1.5 2007/01/15 23:11:12 mcummings Exp $

inherit perl-module

DESCRIPTION="Lightweight HTTP Server"
SRC_URI="mirror://cpan/authors/id/J/JE/JESSE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jesse/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~ia64 ~ppc sparc x86"
IUSE=""
SRC_TEST="do"


DEPEND="dev-lang/perl"
