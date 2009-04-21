# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/B-Hooks-EndOfScope/B-Hooks-EndOfScope-0.08.ebuild,v 1.1 2009/04/21 16:17:51 tove Exp $

EAPI=2

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Execute code after a scope finished compilation"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/Variable-Magic-0.34
	dev-perl/Sub-Exporter"
RDEPEND=${DEPEND}

SRC_TEST=do
