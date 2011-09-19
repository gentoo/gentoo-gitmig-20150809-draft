# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-Flexible/DateTime-Format-Flexible-0.200.0.ebuild,v 1.1 2011/09/19 19:13:32 tove Exp $

EAPI=4

MODULE_AUTHOR=THINC
MODULE_VERSION=0.20
inherit perl-module

DESCRIPTION="Flexibly parse strings and turn them into DateTime objects"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/DateTime
	>=dev-perl/DateTime-Format-Builder-0.74
	dev-perl/DateTime-TimeZone
	virtual/perl-Module-Pluggable"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-MockTime
	)"
#		dev-perl/Test-Pod
#		dev-perl/Test-Pod-Coverage

SRC_TEST=do
