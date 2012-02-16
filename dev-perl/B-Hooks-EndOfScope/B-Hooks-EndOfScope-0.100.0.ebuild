# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/B-Hooks-EndOfScope/B-Hooks-EndOfScope-0.100.0.ebuild,v 1.1 2012/02/16 16:16:24 tove Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.10
inherit perl-module

DESCRIPTION="Execute code after a scope finished compilation"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x64-macos"
IUSE=""

RDEPEND=">=dev-perl/Variable-Magic-0.34
	dev-perl/Sub-Exporter"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31"

SRC_TEST=do
