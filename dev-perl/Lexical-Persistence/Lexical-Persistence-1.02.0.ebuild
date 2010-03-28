# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lexical-Persistence/Lexical-Persistence-1.02.0.ebuild,v 1.1 2010/03/28 00:24:53 robbat2 Exp $

EAPI=2

inherit versionator
MODULE_AUTHOR="RCAPUTO"
MY_P=${PN}-$(get_major_version).$(delete_all_version_separators $(get_after_major_version))
S=${WORKDIR}/${MY_P}
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
