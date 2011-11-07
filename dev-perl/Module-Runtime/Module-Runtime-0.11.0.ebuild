# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Runtime/Module-Runtime-0.11.0.ebuild,v 1.4 2011/11/07 08:15:07 grobian Exp $

EAPI=4

MODULE_AUTHOR=ZEFRAM
MODULE_VERSION=0.011
inherit perl-module

DESCRIPTION="Runtime module handling"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86 ~x86-freebsd ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
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
