# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-ScanDeps/Module-ScanDeps-1.10.0.ebuild,v 1.1 2011/03/27 06:57:20 tove Exp $

EAPI=3

MODULE_AUTHOR=RSCHUPP
MODULE_VERSION=1.01
inherit perl-module

DESCRIPTION="Recursively scan Perl code for dependencies"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="virtual/perl-Module-Build
	virtual/perl-version"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/prefork
		virtual/perl-Module-Pluggable )"

SRC_TEST=do
