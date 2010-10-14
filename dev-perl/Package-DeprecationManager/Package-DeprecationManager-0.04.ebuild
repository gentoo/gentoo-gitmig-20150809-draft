# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Package-DeprecationManager/Package-DeprecationManager-0.04.ebuild,v 1.5 2010/10/14 18:52:47 ranger Exp $

EAPI=3

MODULE_AUTHOR="DROLSKY"
inherit perl-module

DESCRIPTION="Manage deprecation warnings for your distribution"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="test"

RDEPEND="dev-perl/Sub-Install
	dev-perl/Params-Util"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? ( dev-perl/Test-Exception
		>=virtual/perl-Test-Simple-0.88
		dev-perl/Test-Warn )"

SRC_TEST="do"
