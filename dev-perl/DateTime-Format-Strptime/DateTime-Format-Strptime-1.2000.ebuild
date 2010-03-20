# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-Strptime/DateTime-Format-Strptime-1.2000.ebuild,v 1.1 2010/03/20 08:46:25 tove Exp $

EAPI=2

MODULE_AUTHOR=DROLSKY
inherit perl-module

DESCRIPTION="Parse and Format DateTimes using Strptime"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/DateTime
	>=dev-perl/DateTime-Locale-0.45
	>=dev-perl/DateTime-TimeZone-0.79
	>=dev-perl/Params-Validate-0.91"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
