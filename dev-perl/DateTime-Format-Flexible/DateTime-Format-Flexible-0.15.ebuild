# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-Flexible/DateTime-Format-Flexible-0.15.ebuild,v 1.1 2010/03/15 17:56:54 tove Exp $

EAPI=2

MODULE_AUTHOR=THINC
inherit perl-module

DESCRIPTION="Flexibly parse strings and turn them into DateTime objects"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/DateTime
	>=dev-perl/DateTime-Format-Builder-0.74
	dev-perl/DateTime-TimeZone
	virtual/perl-Module-Pluggable"
DEPEND="${RDEPEND}"

SRC_TEST=do
