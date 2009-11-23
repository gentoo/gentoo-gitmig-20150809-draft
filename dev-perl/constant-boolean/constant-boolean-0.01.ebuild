# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/constant-boolean/constant-boolean-0.01.ebuild,v 1.3 2009/11/23 21:03:03 tove Exp $

EAPI=2

MODULE_AUTHOR="DEXTER"
inherit perl-module

DESCRIPTION="Define TRUE and FALSE constants"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="virtual/perl-Module-Build"

SRC_TEST=do
