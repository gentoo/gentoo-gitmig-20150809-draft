# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Role-Tiny/Role-Tiny-1.0.0.ebuild,v 1.2 2012/03/30 16:22:24 tove Exp $

EAPI=4

MODULE_AUTHOR=MSTROUT
MODULE_VERSION=1.000000
inherit perl-module

DESCRIPTION="Roles. Like a nouvelle cusine portion size slice of Moose"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-solaris"
IUSE="test"

DEPEND="
	test? (
		>=dev-perl/Test-Fatal-0.003
		>=virtual/perl-Test-Simple-0.96
	)
"
RDEPEND="
	!<dev-perl/Moo-0.9.14
"

SRC_TEST="do"
