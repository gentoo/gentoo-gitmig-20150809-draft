# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Server-Simple-Mason/HTTP-Server-Simple-Mason-0.09.ebuild,v 1.1 2005/11/23 16:02:18 mcummings Exp $

inherit perl-module

DESCRIPTION="An abstract baseclass for a standalone mason server"
SRC_URI="mirror://cpan/authors/id/J/JE/JESSE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jesse/${PN}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~ppc ~x86"

DEPEND="dev-perl/Hook-LexWrap
		>=dev-perl/HTML-Mason-1.25
		>=dev-perl/HTTP-Server-Simple-0.04"
SRC_TEST="do"
IUSE=""
