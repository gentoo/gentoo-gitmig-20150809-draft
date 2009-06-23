# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lexical-Persistence/Lexical-Persistence-0.98.ebuild,v 1.1 2009/06/23 07:42:26 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="RCAPUTO"

inherit perl-module

DESCRIPTION="Bind lexicals to persistent data."

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/PadWalker
	>=dev-perl/Devel-LexAlias-0.04"
RDEPEND="${DEPEND}"
