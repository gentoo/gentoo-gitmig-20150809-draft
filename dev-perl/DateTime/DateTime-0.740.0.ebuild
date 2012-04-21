# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime/DateTime-0.740.0.ebuild,v 1.1 2012/04/21 02:18:03 robbat2 Exp $

EAPI=4

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=${PV%0.0}
inherit perl-module

DESCRIPTION="A date and time object"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND=">=dev-perl/Params-Validate-0.76
	>=virtual/perl-Time-Local-1.04
	>=dev-perl/DateTime-TimeZone-1.09
	>=dev-perl/DateTime-Locale-0.44
	dev-perl/Math-Round
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Fatal
	)
"

SRC_TEST="do"
