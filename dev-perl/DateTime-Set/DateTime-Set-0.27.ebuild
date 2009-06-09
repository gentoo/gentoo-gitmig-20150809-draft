# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Set/DateTime-Set-0.27.ebuild,v 1.1 2009/06/09 20:06:44 tove Exp $

EAPI=2

MODULE_AUTHOR=FGLOCK
inherit perl-module

DESCRIPTION="Datetime sets and set math"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/DateTime-0.12
	>=dev-perl/Set-Infinite-0.59
	dev-perl/Params-Validate"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
