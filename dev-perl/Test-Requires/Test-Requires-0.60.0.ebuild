# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Requires/Test-Requires-0.60.0.ebuild,v 1.2 2011/10/31 13:15:11 jer Exp $

EAPI=4

MODULE_AUTHOR=TOKUHIROM
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Checks to see if the module can be loaded"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

RDEPEND=">=virtual/perl-Test-Simple-0.61"
DEPEND="${RDEPEND}"

SRC_TEST=do
