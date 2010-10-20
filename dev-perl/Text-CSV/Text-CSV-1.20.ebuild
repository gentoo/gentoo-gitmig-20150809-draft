# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CSV/Text-CSV-1.20.ebuild,v 1.1 2010/10/20 16:18:57 tove Exp $

EAPI=3

MODULE_AUTHOR="MAKAMAKA"
inherit perl-module

DESCRIPTION="Manipulate comma-separated value strings"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Test-Pod )"

SRC_TEST=do
