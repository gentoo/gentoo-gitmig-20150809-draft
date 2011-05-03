# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Accessor-Grouped/Class-Accessor-Grouped-0.100.30.ebuild,v 1.1 2011/05/03 18:22:17 tove Exp $

EAPI=4

MODULE_AUTHOR=FREW
MODULE_VERSION=0.10003
inherit perl-module

DESCRIPTION="Lets you build groups of accessors"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/Class-Inspector
	>=dev-perl/Class-XSAccessor-1.110
	>=dev-perl/Sub-Name-0.05"
DEPEND="${RDEPEND}
	test? ( >=dev-perl/Test-Exception-0.31
		>=virtual/perl-Test-Simple-0.94 )"

SRC_TEST=do
