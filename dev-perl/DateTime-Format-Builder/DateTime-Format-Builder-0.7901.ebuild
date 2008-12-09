# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-Builder/DateTime-Format-Builder-0.7901.ebuild,v 1.2 2008/12/09 09:33:54 tove Exp $

MODULE_AUTHOR="DROLSKY"

inherit perl-module

DESCRIPTION="Create DateTime parser classes and objects"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/DateTime
	dev-perl/Class-Factory-Util
	>=dev-perl/Params-Validate-0.91
	virtual/perl-Module-Build
	>=dev-perl/DateTime-Format-Strptime-1.0800
	dev-perl/Task-Weaken"
