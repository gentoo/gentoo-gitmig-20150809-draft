# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-CoreList/Module-CoreList-2.440.ebuild,v 1.1 2011/01/22 13:31:02 tove Exp $

EAPI=3

MODULE_AUTHOR=BINGOS
MODULE_VERSION=2.44
inherit perl-module

DESCRIPTION="what modules shipped with versions of perl"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

#RDEPEND=""
#DEPEND="test? ( dev-perl/Test-Pod )"

SRC_TEST=do
