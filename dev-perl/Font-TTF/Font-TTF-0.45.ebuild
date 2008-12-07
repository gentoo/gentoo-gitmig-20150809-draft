# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Font-TTF/Font-TTF-0.45.ebuild,v 1.3 2008/12/07 11:23:26 vapier Exp $

inherit perl-module

DESCRIPTION="module for compiling and altering fonts"
HOMEPAGE="http://search.cpan.org/~mhosken/Font-TTF/"
SRC_URI="mirror://cpan/authors/id/M/MH/MHOSKEN/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/perl-Compress-Zlib
	dev-perl/XML-Parser
	dev-lang/perl"

SRC_TEST="do"
