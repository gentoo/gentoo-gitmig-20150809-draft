# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/module-info/module-info-0.320.0.ebuild,v 1.1 2011/08/27 18:27:40 tove Exp $

EAPI=4

MY_PN=Module-Info
MODULE_AUTHOR=MBARBON
MODULE_VERSION=0.32
inherit perl-module

DESCRIPTION="Information about Perl modules"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
