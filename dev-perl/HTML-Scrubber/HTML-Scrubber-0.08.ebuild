# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Scrubber/HTML-Scrubber-0.08.ebuild,v 1.23 2012/02/12 18:07:41 armin76 Exp $

# this is an RT dependency

inherit perl-module

DESCRIPTION="Perl extension for scrubbing/sanitizing html"
SRC_URI="mirror://cpan/authors/id/P/PO/PODMASTER/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~podmaster/"

SRC_TEST="do"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ppc ppc64 x86"

DEPEND="virtual/perl-Test-Simple
	dev-perl/HTML-Parser
	dev-lang/perl"
IUSE=""
