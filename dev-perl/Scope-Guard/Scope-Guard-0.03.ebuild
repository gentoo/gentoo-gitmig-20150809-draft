# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Scope-Guard/Scope-Guard-0.03.ebuild,v 1.4 2009/12/23 19:22:28 grobian Exp $

MODULE_AUTHOR=CHOCOLATE
inherit perl-module

DESCRIPTION="Lexically scoped resource management"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-solaris"
IUSE="test"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
