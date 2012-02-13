# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Stream-Bulk/Data-Stream-Bulk-0.100.0.ebuild,v 1.1 2012/02/13 14:46:49 tove Exp $

EAPI=4

MODULE_AUTHOR=DOY
MODULE_VERSION=0.10
inherit perl-module

DESCRIPTION="N at a time iteration API"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Moose
	dev-perl/Sub-Exporter
	dev-perl/Path-Class
	dev-perl/namespace-clean"
DEPEND=">=virtual/perl-ExtUtils-MakeMaker-6.31
	test? ( ${RDEPEND}
		dev-perl/Test-use-ok
		dev-perl/Test-Requires
	)
"

SRC_TEST=do
