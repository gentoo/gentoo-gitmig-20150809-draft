# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-SharedFork/Test-SharedFork-0.200.0.ebuild,v 1.1 2012/02/29 09:14:36 robbat2 Exp $

EAPI=4

MODULE_AUTHOR=TOKUHIROM
MODULE_VERSION=0.20
inherit perl-module

DESCRIPTION="fork test"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Requires
		>=virtual/perl-Test-Simple-0.88
		virtual/perl-Test-Harness
	)
"

SRC_TEST=do
