# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-Strptime/DateTime-Format-Strptime-1.1000.ebuild,v 1.1 2009/07/15 18:51:16 tove Exp $

EAPI=2

MODULE_AUTHOR="RICKM"
MODULE_A="${P}.tgz"
inherit perl-module

DESCRIPTION="Parse and Format DateTimes using Strptime"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/DateTime
	>=dev-perl/DateTime-Locale-0.43
	>=dev-perl/DateTime-TimeZone-0.79
	>=dev-perl/Params-Validate-0.91"
RDEPEND="${DEPEND}"

SRC_TEST=do
