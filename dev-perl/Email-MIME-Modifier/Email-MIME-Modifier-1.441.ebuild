# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME-Modifier/Email-MIME-Modifier-1.441.ebuild,v 1.4 2007/03/27 11:14:06 armin76 Exp $

inherit perl-module

DESCRIPTION="Modify Email::MIME Objects Easily"
HOMEPAGE="http://search.cpan.org/~rjbs/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"


IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~sparc ~x86"

DEPEND="virtual/perl-Test-Simple
	>=dev-perl/Email-MIME-1.857
	>=dev-perl/Email-MIME-Encodings-1.310
	>=dev-perl/Email-MessageID-1.35
	>=dev-perl/Email-MIME-ContentType-1.012
	dev-perl/Email-Simple
	dev-lang/perl"

SRC_TEST="do"
