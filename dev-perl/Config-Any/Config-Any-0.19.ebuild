# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-Any/Config-Any-0.19.ebuild,v 1.1 2010/03/16 13:55:18 tove Exp $

EAPI=2

MODULE_AUTHOR="BRICAS"
inherit perl-module

DESCRIPTION="Support several config file formats"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/perl-Module-Pluggable-3.9"
RDEPEND="${DEPEND}"

SRC_TEST=do
