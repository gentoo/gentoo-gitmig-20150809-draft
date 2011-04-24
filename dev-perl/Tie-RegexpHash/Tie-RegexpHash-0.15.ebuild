# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-RegexpHash/Tie-RegexpHash-0.15.ebuild,v 1.2 2011/04/24 16:04:40 grobian Exp $

EAPI=2

MODULE_AUTHOR=RCH
inherit perl-module

DESCRIPTION="Use regular expressions as hash keys"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="virtual/perl-Module-Build"

SRC_TEST=do
