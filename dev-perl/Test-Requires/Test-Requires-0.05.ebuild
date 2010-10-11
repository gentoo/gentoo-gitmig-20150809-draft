# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Requires/Test-Requires-0.05.ebuild,v 1.3 2010/10/11 12:53:53 hwoarang Exp $

EAPI=3

MODULE_AUTHOR=TOKUHIROM
inherit perl-module

DESCRIPTION="Checks to see if the module can be loaded"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=virtual/perl-Test-Simple-0.61"
DEPEND="${RDEPEND}"

SRC_TEST=do
