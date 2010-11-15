# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sub-Install/Sub-Install-0.925.ebuild,v 1.6 2010/11/15 10:36:29 grobian Exp $

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="install subroutines into packages easily"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86 ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
