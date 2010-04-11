# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-ScanDeps/Module-ScanDeps-0.97.ebuild,v 1.1 2010/04/11 15:40:53 tove Exp $

EAPI=2

MODULE_AUTHOR=SMUELLER
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
