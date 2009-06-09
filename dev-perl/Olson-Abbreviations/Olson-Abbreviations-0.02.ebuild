# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Olson-Abbreviations/Olson-Abbreviations-0.02.ebuild,v 1.1 2009/06/09 20:38:38 tove Exp $

EAPI=2

MODULE_AUTHOR=ECARROLL
inherit perl-module

DESCRIPTION="globally unique timezones abbreviation handling"

SLOT="0"
KEYWORDS="~x86"
IUSE="test"

RDEPEND="dev-perl/Moose
	dev-perl/MooseX-AttributeHelpers
	dev-perl/MooseX-ClassAttribute"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
