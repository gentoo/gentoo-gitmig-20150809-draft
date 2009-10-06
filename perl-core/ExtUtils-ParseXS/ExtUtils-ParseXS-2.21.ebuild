# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-ParseXS/ExtUtils-ParseXS-2.21.ebuild,v 1.1 2009/10/06 18:46:58 tove Exp $

EAPI=2

#inherit versionator
#MY_P=${PN}-$(delete_version_separator 2 )
#S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=DAGOLDEN
inherit perl-module

DESCRIPTION="Converts Perl XS code into C code"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-CBuilder
	virtual/perl-Module-Build"

SRC_TEST="do"
