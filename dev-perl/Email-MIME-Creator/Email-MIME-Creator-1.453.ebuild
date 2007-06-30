# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME-Creator/Email-MIME-Creator-1.453.ebuild,v 1.3 2007/06/30 16:02:57 armin76 Exp $

inherit perl-module

DESCRIPTION="Email::MIME constructor for starting anew"
HOMEPAGE="http://search.cpan.org/~rjbs/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"


IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 sparc ~x86"

DEPEND=">=dev-perl/Email-Simple-Creator-1.41
	virtual/perl-Test-Simple
	>=dev-perl/Email-MIME-1.857
	>=dev-perl/Email-MIME-Modifier-1.441
	dev-perl/Email-Simple
	dev-lang/perl"

SRC_TEST="do"
