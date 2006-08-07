# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Finance-YahooQuote/Finance-YahooQuote-0.21.ebuild,v 1.10 2006/08/07 22:59:53 mcummings Exp $

inherit perl-module

MY_P=finance-yahooquote_${PV}

DESCRIPTION="Get stock quotes from Yahoo! Finance"
HOMEPAGE="http://search.cpan.org/~edd/${P}/"
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
RDEPEND="${DEPEND}"

