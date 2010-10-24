# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CSV/Text-CSV-1.18.ebuild,v 1.2 2010/10/24 15:36:52 armin76 Exp $

EAPI=2

MODULE_AUTHOR="MAKAMAKA"
inherit perl-module

DESCRIPTION="Manipulate comma-separated value strings"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Test-Pod )"

SRC_TEST=do
