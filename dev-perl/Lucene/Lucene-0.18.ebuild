# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lucene/Lucene-0.18.ebuild,v 1.1 2008/03/19 21:44:11 robbat2 Exp $

MODULE_AUTHOR="TBUSCH"
inherit perl-module

DESCRIPTION="API to the C++ port of the Lucene search engine"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86 ~ppc"

DEPEND="dev-lang/perl
		dev-cpp/clucene"

mydoc="Changes README"
SRC_TEST="do"
