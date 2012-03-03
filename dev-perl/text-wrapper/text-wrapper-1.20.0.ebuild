# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/text-wrapper/text-wrapper-1.20.0.ebuild,v 1.5 2012/03/03 14:43:13 ranger Exp $

EAPI=4

MY_PN=Text-Wrapper
MODULE_AUTHOR=CJM
MODULE_VERSION=1.02
inherit perl-module

DESCRIPTION="The Perl Text::Wrapper Module"

SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
