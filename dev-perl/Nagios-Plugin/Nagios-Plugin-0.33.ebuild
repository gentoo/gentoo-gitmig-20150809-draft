# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Nagios-Plugin/Nagios-Plugin-0.33.ebuild,v 1.1 2009/06/07 13:47:13 tove Exp $

EAPI=2

MODULE_AUTHOR="TONVOON"
inherit perl-module

DESCRIPTION="A family of perl modules to streamline writing Nagios plugins"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Class-Accessor
	dev-perl/Config-Tiny
	dev-perl/Params-Validate
	dev-perl/Math-Calc-Units"
RDEPEND="${DEPEND}"

SRC_TEST="do"
