# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Finance-YahooQuote/Finance-YahooQuote-0.20.ebuild,v 1.4 2005/07/21 17:16:16 dholm Exp $

inherit perl-module

MY_P=finance-yahooquote_${PV}

DESCRIPTION="Get stock quotes from Yahoo! Finance"
HOMEPAGE="http://search.cpan.org/~edd/${P}/"
SRC_URI="mirror://cpan/authors/id/E/ED/EDD/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ppc sparc ~x86"
IUSE=""

# Disabling tests since they rely on a rather fickle expected outcome from a
# stock ping
#SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
		perl-core/MIME-Base64
		dev-perl/HTML-Parser"
