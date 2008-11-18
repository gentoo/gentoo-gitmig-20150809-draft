# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-vFile-asData/Text-vFile-asData-0.05.ebuild,v 1.2 2008/11/18 15:40:40 tove Exp $

MODULE_AUTHOR="RCLAMP"
inherit perl-module

DESCRIPTION="Perl module to parse vFile formatted files into data structures"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86"
IUSE="test"

RDEPEND="dev-lang/perl
	dev-perl/Class-Accessor-Chained"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
