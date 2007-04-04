# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PodToHTML/PodToHTML-0.06.ebuild,v 1.3 2007/04/04 17:04:40 gustavoz Exp $

inherit perl-module

DESCRIPTION="convert POD documentation to HTML"
HOMEPAGE="http://search.cpan.org/~bdfoy"
SRC_URI="mirror://cpan/authors/id/B/BD/BDFOY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/HTML-Tree
	dev-perl/HTML-Parser
	dev-perl/HTML-Format
	virtual/perl-PodParser
	dev-lang/perl"
