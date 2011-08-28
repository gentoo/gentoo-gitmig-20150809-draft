# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sub-Install/Sub-Install-0.925.0.ebuild,v 1.1 2011/08/28 19:02:53 tove Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=0.925
inherit perl-module

DESCRIPTION="install subroutines into packages easily"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
