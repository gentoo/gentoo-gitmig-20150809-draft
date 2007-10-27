# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-AIO/IO-AIO-2.51.ebuild,v 1.1 2007/10/27 02:43:13 robbat2 Exp $

MODULE_AUTHOR="MLEHMANN"
inherit perl-module

DESCRIPTION="Asynchronous Input/Output"
HOMEPAGE="http://search.cpan.org/search?query=IO-AIO&mode=dist"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

mydoc="Changes README"
SRC_TEST="do"
