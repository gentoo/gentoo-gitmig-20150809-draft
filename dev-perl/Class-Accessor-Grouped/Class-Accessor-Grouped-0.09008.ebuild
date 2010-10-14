# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Accessor-Grouped/Class-Accessor-Grouped-0.09008.ebuild,v 1.2 2010/10/14 19:26:48 ranger Exp $

EAPI=3

MODULE_AUTHOR=RIBASUSHI
inherit perl-module

DESCRIPTION="Lets you build groups of accessors"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/Class-Inspector
	dev-perl/Class-XSAccessor
	dev-perl/Sub-Name
	dev-perl/MRO-Compat"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Exception
		>=virtual/perl-Test-Simple-0.94 )"

SRC_TEST=do
