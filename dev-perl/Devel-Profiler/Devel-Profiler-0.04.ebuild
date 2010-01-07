# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Profiler/Devel-Profiler-0.04.ebuild,v 1.15 2010/01/07 07:54:27 tove Exp $

MODULE_AUTHOR=SAMTREGAR
inherit perl-module

DESCRIPTION="a Perl profiler compatible with dprofpp"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
PATCHES=( "${FILESDIR}"/perl510.patch )
