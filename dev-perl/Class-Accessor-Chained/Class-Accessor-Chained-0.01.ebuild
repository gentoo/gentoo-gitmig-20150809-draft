# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Accessor-Chained/Class-Accessor-Chained-0.01.ebuild,v 1.3 2008/12/17 09:49:42 tove Exp $

MODULE_AUTHOR="RCLAMP"
inherit perl-module

DESCRIPTION="Perl module to make chained class accessors"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/Class-Accessor"
DEPEND="virtual/perl-Module-Build"

SRC_TEST="do"
