# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-Any/Config-Any-0.18.ebuild,v 1.1 2009/11/22 10:48:20 robbat2 Exp $

MODULE_AUTHOR="BRICAS"
EAPI=2

inherit perl-module

DESCRIPTION="Support several config file formats"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=virtual/perl-Module-Pluggable-3.9"
RDEPEND="${DEPEND}"
