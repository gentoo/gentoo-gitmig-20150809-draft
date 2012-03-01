# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Finance-YahooQuote/Finance-YahooQuote-0.240.0.ebuild,v 1.3 2012/03/01 20:29:39 ranger Exp $

EAPI=4

MODULE_AUTHOR=EDD
MODULE_VERSION=0.24
inherit perl-module

DESCRIPTION="Get stock quotes from Yahoo! Finance"

LICENSE="|| ( GPL-2 GPL-3 )" # GPL-2+
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/libwww-perl
	virtual/perl-MIME-Base64
	>=dev-perl/HTML-Parser-2.2"
DEPEND="${RDEPEND}"

SRC_TEST=online
