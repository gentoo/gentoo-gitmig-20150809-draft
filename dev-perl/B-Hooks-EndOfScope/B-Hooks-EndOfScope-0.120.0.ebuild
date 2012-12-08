# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/B-Hooks-EndOfScope/B-Hooks-EndOfScope-0.120.0.ebuild,v 1.1 2012/12/08 08:21:57 tove Exp $

EAPI=4

MODULE_AUTHOR=BOBTFISH
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="Execute code after a scope finished compilation"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-perl/Module-Implementation-0.50.0
	>=dev-perl/Module-Runtime-0.12.0
	>=dev-perl/Sub-Exporter-Progressive-0.1.6
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-CBuilder-0.260.0
"

SRC_TEST=do
