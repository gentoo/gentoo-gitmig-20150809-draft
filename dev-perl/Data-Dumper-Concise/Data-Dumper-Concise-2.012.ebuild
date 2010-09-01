# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Dumper-Concise/Data-Dumper-Concise-2.012.ebuild,v 1.1 2010/09/01 06:51:58 tove Exp $

EAPI=3

MODULE_AUTHOR=FREW
inherit perl-module

DESCRIPTION="Less indentation and newlines plus sub deparsing"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#RDEPEND="dev-perl/Devel-ArgNames"
RDEPEND=""
DEPEND="${RDEPEND}"

SRC_TEST=do
