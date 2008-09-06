# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Calendar-Simple/Calendar-Simple-1.20.ebuild,v 1.1 2008/09/06 07:17:41 tove Exp $

MODULE_AUTHOR=DAVECROSS
inherit perl-module

DESCRIPTION="Perl extension to create simple calendars"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="test"

SRC_TEST="do"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	>=dev-perl/module-build-0.28
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"
