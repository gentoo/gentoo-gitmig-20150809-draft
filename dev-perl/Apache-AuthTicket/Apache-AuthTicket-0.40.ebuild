# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-AuthTicket/Apache-AuthTicket-0.40.ebuild,v 1.5 2006/07/03 20:08:15 ian Exp $

inherit perl-module
SRC_TEST="do"

DESCRIPTION="Cookie based access module."
HOMEPAGE="http://search.cpan.org/~mschout/Apache-AuthTicket-0.40/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHOUT/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ia64 x86"
IUSE=""

DEPEND=">=dev-perl/Apache-AuthCookie-3.0
		dev-perl/DBI
		virtual/perl-Digest-MD5
		dev-perl/SQL-Abstract"
RDEPEND="${DEPEND}"