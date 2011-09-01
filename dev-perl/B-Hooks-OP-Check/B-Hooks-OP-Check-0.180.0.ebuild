# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/B-Hooks-OP-Check/B-Hooks-OP-Check-0.180.0.ebuild,v 1.1 2011/09/01 13:10:24 tove Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.18
inherit perl-module

DESCRIPTION="Wrap OP check callbacks"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-parent"
DEPEND=">=dev-perl/extutils-depends-0.302
	${RDEPEND}"

SRC_TEST=do
