# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Trap/Test-Trap-0.2.1.ebuild,v 1.1 2010/11/20 09:22:58 jlec Exp $

EAPI=2

MODULE_AUTHOR=EBHANSSEN
inherit perl-module

MY_P="${PN}-v${PV}"

DESCRIPTION="Trap exit codes, exceptions, output, etc"
SRC_URI="mirror://cpan/authors/id/E/EB/${MODULE_AUTHOR}/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-perl/Data-Dump
	dev-perl/Test-Tester"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.30"

S="${WORKDIR}"/${MY_P}

SRC_TEST="do parallel"
