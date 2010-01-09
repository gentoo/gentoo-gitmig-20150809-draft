# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Carp-Assert/Carp-Assert-0.20.ebuild,v 1.6 2010/01/09 16:44:04 grobian Exp $

MODULE_AUTHOR=MSCHWERN
inherit perl-module

DESCRIPTION="executable comments in carp"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
