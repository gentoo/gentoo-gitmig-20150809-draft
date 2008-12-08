# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Graph/Graph-0.86.ebuild,v 1.1 2008/12/08 02:16:30 robbat2 Exp $

MODULE_AUTHOR=JHI
inherit perl-module

DESCRIPTION="Data structure and ops for directed graphs"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
SRC_TEST="do"

DEPEND="dev-lang/perl"
