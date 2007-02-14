# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME-Encodings/Email-MIME-Encodings-1.310.ebuild,v 1.2 2007/02/14 10:52:01 corsair Exp $

inherit perl-module

DESCRIPTION="A unified interface to MIME encoding and decoding"
HOMEPAGE="http://search.cpan.org/~rjbs/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"


IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"

DEPEND=">=virtual/perl-MIME-Base64-3.07
	dev-lang/perl"

SRC_TEST="do"
