# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-Build/Module-Build-0.36.01.ebuild,v 1.5 2010/01/09 14:50:39 aballier Exp $

EAPI=2

inherit versionator
MODULE_AUTHOR=DAGOLDEN
MY_P=${PN}-$(delete_version_separator 2)
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Build and install Perl modules"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc64 ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND="dev-perl/YAML-Tiny
	>=virtual/perl-ExtUtils-CBuilder-0.27
	>=virtual/perl-Archive-Tar-1.09
	>=virtual/perl-Test-Harness-3.16"
RDEPEND="${DEPEND}"
PDEPEND=">=virtual/perl-ExtUtils-ParseXS-2.21"

SRC_TEST="do"
