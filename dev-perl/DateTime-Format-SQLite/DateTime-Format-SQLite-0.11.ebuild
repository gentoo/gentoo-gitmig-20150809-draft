# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-SQLite/DateTime-Format-SQLite-0.11.ebuild,v 1.2 2010/03/15 19:34:16 tove Exp $

MODULE_AUTHOR="CFAERBER"

inherit perl-module

DESCRIPTION="Parse and format SQLite dates and times"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/DateTime-0.51
	>=dev-perl/DateTime-Format-Builder-0.79.01
	dev-lang/perl"
SRC_TEST=do
