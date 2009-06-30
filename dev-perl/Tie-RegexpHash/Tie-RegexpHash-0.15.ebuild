# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-RegexpHash/Tie-RegexpHash-0.15.ebuild,v 1.1 2009/06/30 19:53:02 tove Exp $

EAPI=2

MODULE_AUTHOR=RCH
inherit perl-module

DESCRIPTION="Use regular expressions as hash keys"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="virtual/perl-Module-Build"

SRC_TEST=do
