# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-Session/CGI-Session-4.20.ebuild,v 1.3 2007/01/21 19:45:55 mcummings Exp $

inherit perl-module

DESCRIPTION="persistent session data in CGI applications "
HOMEPAGE="http://search.cpan.org/~sherzodr"
SRC_URI="mirror://cpan/authors/id/M/MA/MARKSTOS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/perl-Digest-MD5
	dev-lang/perl"
