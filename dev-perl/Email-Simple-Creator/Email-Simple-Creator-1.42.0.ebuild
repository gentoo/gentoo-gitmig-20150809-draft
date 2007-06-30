# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Simple-Creator/Email-Simple-Creator-1.42.0.ebuild,v 1.3 2007/06/30 16:01:26 armin76 Exp $

inherit perl-module versionator

MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Email::Simple constructor for starting anew"
HOMEPAGE="http://search.cpan.org/~rjbs/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${MY_P}.tar.gz"


IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 sparc ~x86"

DEPEND="dev-perl/Email-Date
	virtual/perl-Test-Simple
	dev-perl/Email-Simple
	dev-lang/perl"

SRC_TEST="do"
