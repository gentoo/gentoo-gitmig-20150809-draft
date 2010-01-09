# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Copy-Recursive/File-Copy-Recursive-0.38.ebuild,v 1.7 2010/01/09 20:02:00 grobian Exp $

MODULE_AUTHOR=DMUEY
inherit perl-module

DESCRIPTION="uses File::Copy to recursively copy dirs"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
