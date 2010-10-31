# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Package-DeprecationManager/Package-DeprecationManager-0.10.ebuild,v 1.1 2010/10/31 09:14:19 tove Exp $

EAPI=3

MODULE_AUTHOR="DROLSKY"
inherit perl-module

DESCRIPTION="Manage deprecation warnings for your distribution"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/List-MoreUtils
	dev-perl/Params-Util
	dev-perl/Sub-Install"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? ( dev-perl/Test-Fatal
		>=virtual/perl-Test-Simple-0.88
		dev-perl/Test-Requires
		dev-perl/Test-Output )"

SRC_TEST="do"
