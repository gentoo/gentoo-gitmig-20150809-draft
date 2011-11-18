# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Moo/Moo-0.9.12.ebuild,v 1.1 2011/11/18 16:30:31 tove Exp $

EAPI=4

MODULE_AUTHOR=MSTROUT
MODULE_VERSION=0.009012
inherit perl-module

DESCRIPTION="Minimalist Object Orientation (with Moose compatiblity)"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	>=dev-perl/strictures-1.1.1
	>=dev-perl/Class-Method-Modifiers-1.50.0
"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Fatal-0.003
		>=virtual/perl-Test-Simple-0.96
	)
"

SRC_TEST=do
