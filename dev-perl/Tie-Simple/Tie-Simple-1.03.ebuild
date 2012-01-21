# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-Simple/Tie-Simple-1.03.ebuild,v 1.1 2012/01/21 20:43:26 ssuominen Exp $

EAPI=4

MODULE_AUTHOR=HANENKAMP
inherit perl-module

DESCRIPTION="Module for creating easier variable ties"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker"

SRC_TEST="do"
