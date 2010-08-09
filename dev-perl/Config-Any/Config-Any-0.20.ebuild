# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-Any/Config-Any-0.20.ebuild,v 1.1 2010/08/09 13:27:21 tove Exp $

EAPI=3

MODULE_AUTHOR="BRICAS"
inherit perl-module

DESCRIPTION="Support several config file formats"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/perl-Module-Pluggable-3.9
	!<dev-perl/config-general-2.47"
RDEPEND="${DEPEND}"

SRC_TEST=do
