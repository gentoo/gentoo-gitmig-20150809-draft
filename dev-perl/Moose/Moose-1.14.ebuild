# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Moose/Moose-1.14.ebuild,v 1.3 2010/10/11 12:53:41 hwoarang Exp $

EAPI=3

MODULE_AUTHOR=DROLSKY
#MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="A postmodern object system for Perl 5"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="dev-perl/Data-OptList
	>=virtual/perl-Scalar-List-Utils-1.19
	>=dev-perl/Class-MOP-1.05
	>=dev-perl/List-MoreUtils-0.12
	>=dev-perl/Package-DeprecationManager-0.04
	>=dev-perl/Sub-Exporter-0.980
	dev-perl/Sub-Name
	dev-perl/Try-Tiny
	dev-perl/Devel-GlobalDestruction"
DEPEND="${RDEPEND}
	test? ( >=virtual/perl-Test-Simple-0.88
		>=dev-perl/Test-Exception-0.27
		dev-perl/Test-LongString
		>=dev-perl/Test-Output-0.09
		>=dev-perl/Test-Requires-0.05
		>=dev-perl/Test-Warn-0.11
		dev-perl/Test-Deep
		dev-perl/Module-Refresh
		)"

SRC_TEST=do
