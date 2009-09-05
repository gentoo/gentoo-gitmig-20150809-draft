# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/B-Utils/B-Utils-0.08.ebuild,v 1.1 2009/09/05 11:33:22 tove Exp $

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
