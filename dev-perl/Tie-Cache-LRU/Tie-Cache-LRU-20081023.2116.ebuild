# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-Cache-LRU/Tie-Cache-LRU-20081023.2116.ebuild,v 1.1 2009/07/01 04:50:27 tove Exp $

EAPI=2

MODULE_AUTHOR=MSCHWERN
inherit perl-module

DESCRIPTION="A Least-Recently Used cache"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/enum
	dev-perl/Carp-Assert
	dev-perl/Class-Virtual
	dev-perl/Class-Data-Inheritable"
DEPEND="${RDEPEND}
	test? ( >=virtual/perl-Test-Simple-0.82 )"

SRC_TEST=do
