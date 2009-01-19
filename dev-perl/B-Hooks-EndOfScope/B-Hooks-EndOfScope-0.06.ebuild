# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/B-Hooks-EndOfScope/B-Hooks-EndOfScope-0.06.ebuild,v 1.1 2009/01/19 09:59:08 tove Exp $

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Execute code after a scope finished compilation"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
	>=dev-perl/Variable-Magic-0.27
	dev-perl/Sub-Exporter"
RDEPEND=${DEPEND}

SRC_TEST=do
