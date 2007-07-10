# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME-Encodings/Email-MIME-Encodings-1.311.ebuild,v 1.4 2007/07/10 23:33:30 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="A unified interface to MIME encoding and decoding"
HOMEPAGE="http://search.cpan.org/~rjbs/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 sparc ~x86"

DEPEND=">=virtual/perl-MIME-Base64-3.07
	dev-lang/perl"

SRC_TEST="do"
