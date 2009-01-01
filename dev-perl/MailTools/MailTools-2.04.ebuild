# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MailTools/MailTools-2.04.ebuild,v 1.3 2009/01/01 19:44:05 armin76 Exp $

MODULE_AUTHOR=MARKOV
inherit perl-module

DESCRIPTION="Manipulation of electronic mail addresses"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x86-fbsd"
IUSE="test"
SRC_TEST="do"

RDEPEND=">=virtual/perl-libnet-1.0703
	dev-perl/TimeDate
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"
