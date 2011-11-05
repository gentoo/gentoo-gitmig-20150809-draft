# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-ScanDeps/Module-ScanDeps-1.50.0.ebuild,v 1.1 2011/11/05 09:05:54 tove Exp $

EAPI=4

MODULE_AUTHOR=RSCHUPP
MODULE_VERSION=1.05
inherit perl-module

DESCRIPTION="Recursively scan Perl code for dependencies"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="virtual/perl-Module-Build
	virtual/perl-version"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/prefork
		virtual/perl-Module-Pluggable
	)"

SRC_TEST=do
