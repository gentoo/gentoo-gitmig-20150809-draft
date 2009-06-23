# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-ScanDeps/Module-ScanDeps-0.90.ebuild,v 1.1 2009/06/23 07:43:45 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="SMUELLER"

inherit perl-module

DESCRIPTION="Recursively scan Perl code for dependencies"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/perl-Module-Build"
RDEPEND="${DEPEND}"
