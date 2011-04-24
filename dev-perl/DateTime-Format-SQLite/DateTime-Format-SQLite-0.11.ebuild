# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-SQLite/DateTime-Format-SQLite-0.11.ebuild,v 1.3 2011/04/24 15:45:53 grobian Exp $

MODULE_AUTHOR="CFAERBER"

inherit perl-module

DESCRIPTION="Parse and format SQLite dates and times"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86 ~x86-solaris"

DEPEND=">=dev-perl/DateTime-0.51
	>=dev-perl/DateTime-Format-Builder-0.79.01
	dev-lang/perl"
SRC_TEST=do
