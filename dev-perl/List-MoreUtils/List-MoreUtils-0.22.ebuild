# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/List-MoreUtils/List-MoreUtils-0.22.ebuild,v 1.7 2010/01/10 13:28:03 grobian Exp $

MODULE_AUTHOR=VPARSEVAL
inherit perl-module

DESCRIPTION="Provide the missing functionality from List::Util"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ~ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
