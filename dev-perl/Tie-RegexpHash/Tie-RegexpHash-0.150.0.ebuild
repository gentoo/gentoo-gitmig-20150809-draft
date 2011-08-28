# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-RegexpHash/Tie-RegexpHash-0.150.0.ebuild,v 1.1 2011/08/28 11:42:43 tove Exp $

EAPI=4

MODULE_AUTHOR=RCH
MODULE_VERSION=0.15
inherit perl-module

DESCRIPTION="Use regular expressions as hash keys"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="virtual/perl-Module-Build"

SRC_TEST=do
