# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Nagios-Plugin/Nagios-Plugin-0.31.ebuild,v 1.1 2009/02/15 20:33:22 dertobi123 Exp $

MODULE_AUTHOR="TONVOON"
inherit perl-module

DESCRIPTION="A family of perl modules to streamline writing Nagios plugins"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl
	dev-perl/Class-Accessor
	dev-perl/Config-Tiny
	dev-perl/Params-Validate
	dev-perl/Math-Calc-Units"
RDEPEND="${DEPEND}"
