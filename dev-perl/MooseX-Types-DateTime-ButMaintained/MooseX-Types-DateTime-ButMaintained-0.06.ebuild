# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Types-DateTime-ButMaintained/MooseX-Types-DateTime-ButMaintained-0.06.ebuild,v 1.1 2009/06/09 21:20:21 tove Exp $

EAPI=2

MODULE_AUTHOR=ECARROLL
inherit perl-module

DESCRIPTION="DateTime related constraints and coercions for Moose"

SLOT="0"
KEYWORDS="~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/DateTime-0.43.02
	>=dev-perl/DateTime-Format-DateParse-0.04
	>=dev-perl/DateTime-Format-Flexible-0.05
	>=dev-perl/DateTime-Format-Natural-0.71
	>=dev-perl/DateTime-Locale-0.40.01
	>=dev-perl/DateTime-TimeZone-0.77.01
	>=dev-perl/DateTimeX-Easy-0.082
	>=dev-perl/Moose-0.41
	>=dev-perl/MooseX-Types-0.04
	>=dev-perl/namespace-clean-0.08
	dev-perl/Olson-Abbreviations
"
DEPEND="${RDEPEND}
	test? ( >=dev-perl/Test-Exception-0.27
		>=dev-perl/Test-use-ok-0.02
		>=dev-perl/Time-Duration-Parse-0.06 )"

SRC_TEST=do
