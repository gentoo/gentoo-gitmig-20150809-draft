# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-CBuilder/ExtUtils-CBuilder-0.26.03.ebuild,v 1.6 2009/12/10 21:30:45 ranger Exp $

EAPI=2

inherit versionator
MY_P=${PN}-$(delete_version_separator 2 )
MODULE_AUTHOR=DAGOLDEN
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Compile and link C code for Perl modules"

SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~m68k ~mips ~ppc ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
