# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Runtime/Module-Runtime-0.13.0.ebuild,v 1.4 2012/03/25 14:24:43 ranger Exp $

EAPI=4

MODULE_AUTHOR=ZEFRAM
MODULE_VERSION=0.013
inherit perl-module

DESCRIPTION="Runtime module handling"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
