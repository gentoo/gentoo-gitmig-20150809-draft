# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Util/Params-Util-0.35.ebuild,v 1.1 2008/11/21 10:08:38 tove Exp $

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Utility functions to aid in parameter checking"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=virtual/perl-Scalar-List-Utils-1.18
	dev-lang/perl"
