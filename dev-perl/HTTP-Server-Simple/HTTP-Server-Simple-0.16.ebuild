# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Server-Simple/HTTP-Server-Simple-0.16.ebuild,v 1.1 2005/11/23 15:53:28 mcummings Exp $

inherit perl-module

DESCRIPTION="HTTP::Server::Simple is a very simple standalone HTTP daemon with
no non-core module dependencies."
SRC_URI="mirror://cpan/authors/id/J/JE/JESSE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/src/JESSE/${P}/README"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""
SRC_TEST="do"
