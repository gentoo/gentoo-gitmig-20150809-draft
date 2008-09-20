# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Array-Window/Array-Window-1.02.ebuild,v 1.3 2008/09/20 12:21:55 coldwind Exp $

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Array::Window - Calculate windows/subsets/pages of arrays"

SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE="test"

RDEPEND="dev-lang/perl
	dev-perl/Params-Util"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
