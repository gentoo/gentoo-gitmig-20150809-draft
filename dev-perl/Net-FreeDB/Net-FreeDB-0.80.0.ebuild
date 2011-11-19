# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-FreeDB/Net-FreeDB-0.80.0.ebuild,v 1.1 2011/11/19 09:34:03 tove Exp $

EAPI=4

MODULE_AUTHOR=ROAM
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="OOP interface to the FreeDB database"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-perl/CDDB-File-1.10.0
	virtual/perl-libnet
	>=virtual/perl-File-Temp-0.50.0
"
DEPEND="${RDEPEND}
"

SRC_TEST=online
