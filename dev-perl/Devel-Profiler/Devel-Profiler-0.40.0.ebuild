# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Profiler/Devel-Profiler-0.40.0.ebuild,v 1.2 2011/09/03 21:05:23 tove Exp $

EAPI=4

MODULE_AUTHOR=SAMTREGAR
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="a Perl profiler compatible with dprofpp"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"
PATCHES=( "${FILESDIR}"/perl510.patch )
