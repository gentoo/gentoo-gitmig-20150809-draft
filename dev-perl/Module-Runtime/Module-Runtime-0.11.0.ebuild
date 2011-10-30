# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Runtime/Module-Runtime-0.11.0.ebuild,v 1.1 2011/10/30 17:14:52 tove Exp $

EAPI=4

MODULE_AUTHOR=ZEFRAM
MODULE_VERSION=0.011
inherit perl-module

DESCRIPTION="Runtime module handling"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Params-Classify
	virtual/perl-parent
"
DEPEND="
	${RDEPEND}
	virtual/perl-Module-Build
	test? (
		virtual/perl-Test-Simple
	)
"

SRC_TEST="do"
