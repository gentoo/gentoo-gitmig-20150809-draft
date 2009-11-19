# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Reply/Email-Reply-1.202.ebuild,v 1.9 2009/11/19 16:45:32 mr_bones_ Exp $

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Reply to a Message"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=dev-perl/Email-Abstract-2.13.1
	>=dev-perl/Email-MIME-1.857
	|| (
		>=dev-perl/Email-MIME-1.900
		(
			>=dev-perl/Email-MIME-Modifier-1.441
			>=dev-perl/Email-MIME-Creator-1.451
		)
	)
	dev-perl/Email-Address
	dev-lang/perl"

SRC_TEST="do"
