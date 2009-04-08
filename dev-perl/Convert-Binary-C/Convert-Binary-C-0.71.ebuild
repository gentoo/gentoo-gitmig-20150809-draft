# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-Binary-C/Convert-Binary-C-0.71.ebuild,v 1.1 2009/04/08 16:07:08 weaver Exp $

EAPI=2

MODULE_AUTHOR=MHX

inherit perl-module

DESCRIPTION="Binary Data Conversion using C Types"
HOMEPAGE="http://search.cpan.org/~mhx/Convert-Binary-C-0.71/lib/Convert/Binary/C.pm"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND=""
RDEPEND=""

MAKEOPTS+=" -j1"
