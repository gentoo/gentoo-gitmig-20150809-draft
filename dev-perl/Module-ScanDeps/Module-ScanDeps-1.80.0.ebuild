# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-ScanDeps/Module-ScanDeps-1.80.0.ebuild,v 1.7 2012/05/06 17:41:49 armin76 Exp $

EAPI=4

MODULE_AUTHOR=RSCHUPP
MODULE_VERSION=1.08
inherit perl-module

DESCRIPTION="Recursively scan Perl code for dependencies"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x64-macos ~x86-macos"
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
