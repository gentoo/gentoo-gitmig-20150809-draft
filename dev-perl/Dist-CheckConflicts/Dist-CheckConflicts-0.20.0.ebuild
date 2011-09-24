# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Dist-CheckConflicts/Dist-CheckConflicts-0.20.0.ebuild,v 1.3 2011/09/24 13:23:50 grobian Exp $

EAPI=4

MODULE_AUTHOR=DOY
MODULE_VERSION=0.02
inherit perl-module

DESCRIPTION="Declare version conflicts for your dist"

SLOT="0"
KEYWORDS="amd64 ppc x86 ~x64-macos"
IUSE="test"

RDEPEND="dev-perl/Sub-Exporter
	>=dev-perl/List-MoreUtils-0.12"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Fatal
		>=virtual/perl-Test-Simple-0.88
	)"

SRC_TEST="do"
