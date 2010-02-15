# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Dumpvar/Devel-Dumpvar-1.06.ebuild,v 1.1 2010/02/15 12:33:55 tove Exp $

EAPI=2

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Pure-OO reimplementation of dumpvar.pl"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/perl-Scalar-List-Utils-1.18"
DEPEND="${RDEPEND}"

SRC_TEST=do
