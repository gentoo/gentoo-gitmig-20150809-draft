# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE-API-Peek/POE-API-Peek-2.16.ebuild,v 1.1 2010/10/05 17:42:54 tove Exp $

EAPI=3

MODULE_AUTHOR="SUNGO"
inherit perl-module

DESCRIPTION="Peek into the internals of a running POE env"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Devel-Size
	>=dev-perl/POE-1.293"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31"

SRC_TEST=do
