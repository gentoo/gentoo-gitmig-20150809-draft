# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-Build/Module-Build-0.34.0201.ebuild,v 1.5 2009/12/07 23:05:47 maekke Exp $

inherit versionator
MODULE_AUTHOR=DAGOLDEN
MY_P=${PN}-$(delete_version_separator 2)
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Build and install Perl modules"

SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

# Removing these as hard deps. They are listed as recommended in the Build.PL,
# but end up causing a dep loop since they require module-build to be built.
# ~mcummings 06.16.06
PDEPEND=">=virtual/perl-ExtUtils-CBuilder-0.15
	>=virtual/perl-ExtUtils-ParseXS-1.02"

DEPEND="dev-lang/perl
	dev-perl/yaml
	>=virtual/perl-Archive-Tar-1.09
	>=virtual/perl-Test-Harness-3.16"

SRC_TEST="do"
