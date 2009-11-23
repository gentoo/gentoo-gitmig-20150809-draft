# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-DateManip/DateTime-Format-DateManip-0.04.ebuild,v 1.3 2009/11/23 17:50:36 tove Exp $

EAPI=2

MODULE_SECTION=dt-fmt-datemanip
MODULE_AUTHOR=BBENNETT
inherit perl-module

DESCRIPTION="convert Date::Manip dates and durations to DateTimes and vice versa"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/DateManip
	dev-perl/DateTime"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
