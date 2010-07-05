# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME-ContentType/Email-MIME-ContentType-1.015.ebuild,v 1.4 2010/07/05 09:10:59 scarabeus Exp $

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Parse a MIME Content-Type Header"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~sparc-solaris ~x86-solaris"
IUSE="test"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
