# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/B-Hooks-Parser/B-Hooks-Parser-0.09.ebuild,v 1.2 2009/11/23 15:51:10 tove Exp $

EAPI=2

MODULE_AUTHOR="FLORA"
inherit perl-module

DESCRIPTION="Interface to perls parser variables"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/B-Hooks-OP-Check"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.302
	test? ( dev-perl/Test-Exception
		dev-perl/B-Hooks-EndOfScope )"
SRC_TEST=do
