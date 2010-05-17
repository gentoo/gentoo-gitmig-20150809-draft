# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Color-Library/Color-Library-0.02.ebuild,v 1.2 2010/05/17 13:17:10 tove Exp $

EAPI=2

MODULE_AUTHOR=RKRIMEN
inherit perl-module

DESCRIPTION="An easy-to-use and comprehensive named-color library"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-Module-Pluggable
	dev-perl/Class-Accessor
	dev-perl/Class-Data-Inheritable"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
