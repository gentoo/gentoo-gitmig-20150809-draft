# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-AuthTicket/Apache-AuthTicket-0.40.ebuild,v 1.1 2005/11/04 18:47:11 chriswhite Exp $

inherit perl-module
SRC_TEST="do"

DESCRIPTION="Cookie based access module."
HOMEPAGE="http://search.cpan.org/~mschout/Apache-AuthTicket-0.40/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHOUT/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-perl/Apache-AuthCookie-3.0
		dev-perl/DBI
		perl-core/Digest-MD5
		dev-perl/SQL-Abstract"
RDEPEND=""

