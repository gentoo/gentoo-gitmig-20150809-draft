# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Graph/Graph-0.91.ebuild,v 1.4 2009/05/31 16:23:26 armin76 Exp $

MODULE_AUTHOR=JHI
inherit perl-module

DESCRIPTION="Data structure and ops for directed graphs"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl
	>=virtual/perl-Storable-2.05"

SRC_TEST="do"
