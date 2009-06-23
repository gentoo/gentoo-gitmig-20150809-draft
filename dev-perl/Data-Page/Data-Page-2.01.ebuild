# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Page/Data-Page-2.01.ebuild,v 1.2 2009/06/23 13:27:38 tove Exp $

EAPI=2

MODULE_AUTHOR=LBROCARD
inherit perl-module

DESCRIPTION="help when paging through sets of results"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Class-Accessor-Chained"
DEPEND="virtual/perl-Module-Build
	test? ( ${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/Test-Exception )"

SRC_TEST=do
