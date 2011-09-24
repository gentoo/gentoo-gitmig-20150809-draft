# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Visitor/Data-Visitor-0.270.0.ebuild,v 1.2 2011/09/24 13:22:12 grobian Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.27
inherit perl-module

DESCRIPTION="A visitor for Perl data structures"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE="test"

RDEPEND="
	>=dev-perl/Moose-0.89
	>=dev-perl/namespace-clean-0.08
	>=dev-perl/Tie-ToObject-0.01
"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-use-ok )"

SRC_TEST="do"
