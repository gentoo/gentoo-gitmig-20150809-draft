# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-Build/Module-Build-0.36.01.ebuild,v 1.2 2009/12/24 16:32:55 jer Exp $

EAPI=2

inherit versionator
MODULE_AUTHOR=DAGOLDEN
MY_P=${PN}-$(delete_version_separator 2)
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Build and install Perl modules"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

DEPEND="dev-perl/YAML-Tiny
	>=virtual/perl-ExtUtils-CBuilder-0.27
	>=virtual/perl-Archive-Tar-1.09
	>=virtual/perl-Test-Harness-3.16"
RDEPEND="${DEPEND}"
PDEPEND=">=virtual/perl-ExtUtils-ParseXS-2.21"

SRC_TEST="do"
