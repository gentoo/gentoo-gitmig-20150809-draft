# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Trap/Test-Trap-0.2.1.ebuild,v 1.2 2011/09/25 09:22:23 tove Exp $

EAPI=2

MODULE_AUTHOR=EBHANSSEN
MODULE_VERSION=v0.2.1
inherit perl-module

DESCRIPTION="Trap exit codes, exceptions, output, etc"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-perl/Data-Dump
	dev-perl/Test-Tester"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.30"

SRC_TEST="do parallel"
