# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTimeX-Easy/DateTimeX-Easy-0.089.ebuild,v 1.1 2010/08/24 16:33:01 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=ROKR
inherit perl-module

DESCRIPTION="Parse a date/time string using the best method available"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/DateTime
	dev-perl/TimeDate
	dev-perl/DateTime-Format-DateManip
	dev-perl/DateTime-Format-Flexible
	dev-perl/DateTime-Format-ICal
	dev-perl/DateTime-Format-Natural
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Most )"

SRC_TEST=do
