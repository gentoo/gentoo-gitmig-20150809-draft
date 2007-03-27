# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME/Email-MIME-1.858.ebuild,v 1.3 2007/03/27 22:14:25 mabi Exp $

inherit perl-module

DESCRIPTION="Easy MIME message parsing"
HOMEPAGE="http://search.cpan.org/~rjbs/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"


IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND="virtual/perl-Test-Simple
	>=dev-perl/Email-MIME-Encodings-1.310
	>=dev-perl/Email-MIME-ContentType-1.012
	dev-perl/Email-Simple
	>=dev-perl/MIME-Types-1.18
	dev-lang/perl"

SRC_TEST="do"
