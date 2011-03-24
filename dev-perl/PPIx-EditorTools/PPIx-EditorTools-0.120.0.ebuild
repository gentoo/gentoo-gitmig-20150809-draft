# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PPIx-EditorTools/PPIx-EditorTools-0.120.0.ebuild,v 1.1 2011/03/24 06:47:53 tove Exp $

EAPI=3

MODULE_AUTHOR=SZABGAB
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="Utility methods and base class for manipulating Perl via PPI"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Class-XSAccessor-1.02
	>=dev-perl/PPI-1.203"
DEPEND="test? ( ${RDEPEND}
		dev-perl/Test-Most
		>=dev-perl/Test-Differences-0.48.01 )"

SRC_TEST=do
