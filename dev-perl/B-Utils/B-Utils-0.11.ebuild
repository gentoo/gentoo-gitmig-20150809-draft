# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/B-Utils/B-Utils-0.11.ebuild,v 1.1 2010/01/16 21:43:27 tove Exp $

EAPI=2

MODULE_AUTHOR="JJORE"
inherit perl-module

DESCRIPTION="Helper functions for op tree manipulation"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=">=dev-perl/extutils-depends-0.302"

SRC_TEST=do
