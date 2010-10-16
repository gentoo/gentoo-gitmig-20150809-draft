# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Finance-YahooQuote/Finance-YahooQuote-0.22.ebuild,v 1.6 2010/10/16 07:12:19 tove Exp $

inherit perl-module

DESCRIPTION="Get stock quotes from Yahoo! Finance"
HOMEPAGE="http://search.cpan.org/~edd/"
SRC_URI="mirror://cpan/authors/id/E/ED/EDD/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""

SRC_TEST=online

DEPEND="dev-perl/libwww-perl
	virtual/perl-MIME-Base64
	>=dev-perl/HTML-Parser-2.2
	dev-lang/perl"
