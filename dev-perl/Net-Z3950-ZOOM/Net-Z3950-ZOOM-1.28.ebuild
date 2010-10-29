# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Z3950-ZOOM/Net-Z3950-ZOOM-1.28.ebuild,v 1.1 2010/10/29 02:06:06 robbat2 Exp $

EAPI=3

MODULE_AUTHOR="MIRK"
inherit perl-module

DESCRIPTION="Perl extension for invoking the ZOOM-C API"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-libs/yaz-2.1.50"
DEPEND="${RDEPEND}"

#SRC_TEST=online
