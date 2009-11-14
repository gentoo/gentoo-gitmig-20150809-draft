# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Hash-Merge/Hash-Merge-0.11.ebuild,v 1.1 2009/11/14 10:50:20 robbat2 Exp $

MODULE_AUTHOR="DMUEY"

inherit perl-module

DESCRIPTION="Merges arbitrarily deep hashes into a single hash"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Clone
	dev-lang/perl"
SRC_TEST=do
