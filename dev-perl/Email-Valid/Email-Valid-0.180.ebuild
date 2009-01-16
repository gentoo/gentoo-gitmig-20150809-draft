# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Valid/Email-Valid-0.180.ebuild,v 1.1 2009/01/16 20:19:17 robbat2 Exp $

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Check validity of Internet email addresses."

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
LICENSE="|| ( GPL-2 Artistic )"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/MailTools
	dev-perl/Net-DNS
	dev-lang/perl"
