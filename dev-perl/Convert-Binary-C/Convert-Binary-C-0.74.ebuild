# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-Binary-C/Convert-Binary-C-0.74.ebuild,v 1.1 2009/04/21 17:11:26 tove Exp $

EAPI=2

MODULE_AUTHOR=MHX
inherit perl-module

DESCRIPTION="Binary Data Conversion using C Types"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

MAKEOPTS+=" -j1"
SRC_TEST="do"
