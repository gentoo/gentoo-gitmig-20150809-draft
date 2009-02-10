# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Algorithm-Dependency/Algorithm-Dependency-1.107.ebuild,v 1.1 2009/02/10 14:02:45 tove Exp $

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Toolkit for implementing dependency systems"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Params-Util-0.31
	>=virtual/perl-File-Spec-0.82
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-ClassAPI )"

SRC_TEST="do"
