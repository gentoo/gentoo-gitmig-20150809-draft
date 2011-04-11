# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-Binary-C/Convert-Binary-C-0.750.0.ebuild,v 1.1 2011/04/11 09:10:19 tove Exp $

EAPI=4

MODULE_AUTHOR=MHX
MODULE_VERSION=0.75
inherit perl-module

DESCRIPTION="Binary Data Conversion using C Types"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

MAKEOPTS+=" -j1"
SRC_TEST="do"
