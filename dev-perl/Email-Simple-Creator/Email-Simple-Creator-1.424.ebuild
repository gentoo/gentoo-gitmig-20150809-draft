# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Simple-Creator/Email-Simple-Creator-1.424.ebuild,v 1.1 2008/09/30 12:42:29 tove Exp $

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Email::Simple constructor for starting anew"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND="dev-perl/Email-Date-Format
	dev-perl/Email-Simple
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		virtual/perl-Test-Simple )"

SRC_TEST="do"
