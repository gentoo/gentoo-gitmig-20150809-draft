# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Copy-Recursive/File-Copy-Recursive-0.38.ebuild,v 1.4 2009/05/03 17:47:02 maekke Exp $

MODULE_AUTHOR=DMUEY
inherit perl-module

DESCRIPTION="uses File::Copy to recursively copy dirs"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ppc ~sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
