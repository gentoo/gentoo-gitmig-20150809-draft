# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Color-Library/Color-Library-0.20.0.ebuild,v 1.1 2011/09/01 10:53:21 tove Exp $

EAPI=4

MODULE_AUTHOR=RKRIMEN
MODULE_VERSION=0.02
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
