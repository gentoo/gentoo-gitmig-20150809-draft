# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Simple-Creator/Email-Simple-Creator-1.41.ebuild,v 1.4 2007/03/27 22:18:26 mabi Exp $

inherit perl-module

DESCRIPTION="Email::Simple constructor for starting anew"
HOMEPAGE="http://search.cpan.org/~rjbs/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"


IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND="dev-perl/Email-Date
	virtual/perl-Test-Simple
	dev-perl/Email-Simple
	dev-lang/perl"

SRC_TEST="do"
