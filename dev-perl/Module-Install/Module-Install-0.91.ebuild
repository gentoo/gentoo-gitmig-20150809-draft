# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Install/Module-Install-0.91.ebuild,v 1.1 2009/06/23 07:43:29 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="ADAMK"

inherit perl-module

DESCRIPTION="Standalone, extensible Perl module installer"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/File-Remove
	>=virtual/perl-Module-Build-0.33
	virtual/perl-Archive-Tar
	>=dev-perl/Parse-CPAN-Meta-1.39
	>=dev-perl/YAML-Tiny-1.39
	virtual/perl-ExtUtils-ParseXS
	dev-perl/PAR-Dist
	>=dev-perl/Module-ScanDeps-0.90
	dev-perl/JSON
	>=dev-perl/Module-CoreList-2.17"
RDEPEND="${DEPEND}"
