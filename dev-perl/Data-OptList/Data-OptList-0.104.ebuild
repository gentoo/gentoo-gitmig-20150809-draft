# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-OptList/Data-OptList-0.104.ebuild,v 1.3 2009/12/02 09:40:46 tove Exp $

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="parse and validate simple name/value option pairs"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="test"

RDEPEND="dev-lang/perl
	dev-perl/Sub-Install
	dev-perl/Params-Util"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
