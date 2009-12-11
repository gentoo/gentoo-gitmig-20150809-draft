# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-SQLite/DateTime-Format-SQLite-0.11.ebuild,v 1.1 2009/12/11 18:53:13 tove Exp $

MODULE_AUTHOR="CFAERBER"

inherit perl-module

DESCRIPTION="Parse and format SQLite dates and times"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/DateTime-0.51
	>=dev-perl/DateTime-Format-Builder-0.7901
	dev-lang/perl"
SRC_TEST=do
