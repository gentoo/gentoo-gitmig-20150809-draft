# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Unload/Class-Unload-0.05.ebuild,v 1.1 2010/02/15 12:31:25 tove Exp $

EAPI=2

MODULE_AUTHOR=ILMARI
inherit perl-module

DESCRIPTION="Unload a class"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Class-Inspector"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple
		>=dev-perl/Test-Pod-1.22
		>=dev-perl/Test-Pod-Coverage-1.08 )"

SRC_TEST=do
