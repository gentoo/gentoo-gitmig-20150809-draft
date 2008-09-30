# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-SmallProf/Devel-SmallProf-2.02.ebuild,v 1.5 2008/09/30 12:24:22 tove Exp $

MODULE_AUTHOR=SALVA
inherit perl-module

DESCRIPTION="per-line Perl profiler"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
