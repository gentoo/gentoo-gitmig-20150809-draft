# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-HiRes/DateTime-HiRes-0.01.ebuild,v 1.2 2009/06/23 08:54:08 tove Exp $

EAPI=2

MODULE_AUTHOR="JHOBLITT"
inherit perl-module

DESCRIPTION="Create DateTime objects with sub-second current time resolution"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/DateTime"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
