# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Finance-YahooQuote/Finance-YahooQuote-0.21.ebuild,v 1.11 2007/01/15 19:47:56 mcummings Exp $

inherit perl-module

MY_P=finance-yahooquote_${PV}

DESCRIPTION="Get stock quotes from Yahoo! Finance"
HOMEPAGE="http://search.cpan.org/~edd/"
SRC_URI=mirror://gentoo/${MY_P}.tar.gz

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""

# Disabling tests since they rely on a rather fickle expected outcome from a
# stock ping
#SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
	virtual/perl-MIME-Base64
		dev-perl/HTML-Parser
	dev-lang/perl"
