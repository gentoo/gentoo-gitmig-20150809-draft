# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/module-info/module-info-0.32.ebuild,v 1.1 2010/09/09 05:29:30 tove Exp $

EAPI=3

MODULE_AUTHOR=MBARBON
MY_PN=Module-Info
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

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
