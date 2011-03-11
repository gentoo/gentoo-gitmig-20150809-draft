# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/namespace-clean/namespace-clean-0.200.ebuild,v 1.2 2011/03/11 18:49:36 hwoarang Exp $

EAPI=3

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.20
inherit perl-module

DESCRIPTION="Keep imports and functions out of your namespace"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Package-Stash-0.220
	>=dev-perl/Sub-Identify-0.04
	>=dev-perl/Sub-Name-0.04
	>=dev-perl/B-Hooks-EndOfScope-0.07"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? ( >=virtual/perl-Test-Simple-0.88 )"

SRC_TEST=do
