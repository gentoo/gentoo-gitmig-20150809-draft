# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Color-Library/Color-Library-0.21.0.ebuild,v 1.1 2011/12/19 16:00:31 tove Exp $

EAPI=4

MODULE_AUTHOR=ROKR
MODULE_VERSION=0.021
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
