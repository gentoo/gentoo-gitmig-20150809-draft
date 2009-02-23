# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-Strptime/DateTime-Format-Strptime-1.0900.ebuild,v 1.1 2009/02/23 10:02:47 robbat2 Exp $

MODULE_AUTHOR="RICKM"
MODULE_A="${P}.tgz"

inherit perl-module

DESCRIPTION="Parse and Format DateTimes using Strptime"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/DateTime
	dev-perl/DateTime-Locale
	dev-perl/DateTime-TimeZone
	>=dev-perl/Params-Validate-0.91
	dev-lang/perl"
