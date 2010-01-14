# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-LongString/Test-LongString-0.11.ebuild,v 1.10 2010/01/14 14:36:42 grobian Exp $

MODULE_AUTHOR=RGARCIA
inherit perl-module

DESCRIPTION="A library to test long strings."

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ~ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
