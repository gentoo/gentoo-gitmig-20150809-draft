# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Dumper-Concise/Data-Dumper-Concise-1.002.ebuild,v 1.1 2009/11/22 21:06:43 robbat2 Exp $

MODULE_AUTHOR="MSTROUT"

inherit perl-module

DESCRIPTION="Less indentation and newlines plus sub deparsing"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lang/perl"
SRC_TEST=do
