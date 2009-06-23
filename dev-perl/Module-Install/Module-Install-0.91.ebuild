# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Install/Module-Install-0.91.ebuild,v 1.2 2009/06/23 08:34:00 tove Exp $

EAPI=2

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Standalone, extensible Perl module installer"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/File-Remove-1.42
	>=virtual/perl-File-Spec-3.27.01
	>=virtual/perl-Module-Build-0.33
	>=virtual/perl-Archive-Tar-1.44
	>=dev-perl/Parse-CPAN-Meta-1.39
	>=dev-perl/YAML-Tiny-1.38
	>=virtual/perl-ExtUtils-ParseXS-2.19
	>=dev-perl/PAR-Dist-0.29
	>=dev-perl/Module-ScanDeps-0.89
	>=dev-perl/JSON-2.14
	>=virtual/perl-Module-CoreList-2.17"

DEPEND="${RDEPEND}
	test? ( >=virtual/perl-Test-Harness-3.13
		>=virtual/perl-Test-Simple-0.86 )"

SRC_TEST=do
