# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Dumper-Concise/Data-Dumper-Concise-2.010.ebuild,v 1.1 2010/08/04 09:23:22 tove Exp $

EAPI=2

MODULE_AUTHOR=FREW
inherit perl-module

DESCRIPTION="Less indentation and newlines plus sub deparsing"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Devel-ArgNames"
DEPEND="${RDEPEND}"

SRC_TEST=do
