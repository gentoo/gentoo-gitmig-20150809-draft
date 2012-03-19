# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Calendar-Simple/Calendar-Simple-1.20.ebuild,v 1.5 2012/03/19 19:29:00 armin76 Exp $

MODULE_AUTHOR=DAVECROSS
inherit perl-module

DESCRIPTION="Perl extension to create simple calendars"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="test"

SRC_TEST="do"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"
