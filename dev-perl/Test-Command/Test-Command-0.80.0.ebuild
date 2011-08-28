# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Command/Test-Command-0.80.0.ebuild,v 1.1 2011/08/28 14:10:42 tove Exp $

EAPI=4

MODULE_AUTHOR=DANBOO
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="Test routines for external commands"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
