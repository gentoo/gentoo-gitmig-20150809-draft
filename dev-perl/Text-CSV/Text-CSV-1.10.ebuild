# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CSV/Text-CSV-1.10.ebuild,v 1.3 2009/01/17 22:16:57 robbat2 Exp $

MODULE_AUTHOR="MAKAMAKA"

inherit perl-module

DESCRIPTION="Manipulate comma-separated value strings"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
