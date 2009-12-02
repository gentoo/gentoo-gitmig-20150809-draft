# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sub-Identify/Sub-Identify-0.04.ebuild,v 1.3 2009/12/02 09:51:57 tove Exp $

MODULE_AUTHOR=RGARCIA
inherit perl-module

DESCRIPTION="Retrieve names of code references"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="test"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
