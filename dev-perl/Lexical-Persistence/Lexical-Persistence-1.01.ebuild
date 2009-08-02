# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lexical-Persistence/Lexical-Persistence-1.01.ebuild,v 1.1 2009/08/02 19:34:14 tove Exp $

EAPI=2

MODULE_AUTHOR="RCAPUTO"
inherit perl-module

DESCRIPTION="Bind lexicals to persistent data."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/PadWalker
	>=dev-perl/Devel-LexAlias-0.04"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
