# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/File-Spec/File-Spec-3.27.01.ebuild,v 1.4 2009/05/02 16:05:23 nixnut Exp $

inherit versionator
MODULE_AUTHOR=KWILLIAMS
MY_PN=PathTools
MY_P=${MY_PN}-$(delete_version_separator 2)
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Handling files and directories portably"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
SRC_TEST="do"

RDEPEND="dev-lang/perl
	virtual/perl-ExtUtils-CBuilder"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

myconf='INSTALLDIRS=vendor'
