# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MakeMethods/Class-MakeMethods-1.01.ebuild,v 1.13 2011/04/24 15:30:04 grobian Exp $

MODULE_AUTHOR=EVO
inherit perl-module

DESCRIPTION="Automated method creation module for Perl"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 arm hppa ia64 ppc s390 sh sparc x86 ~x86-solaris"
IUSE=""

SRC_TEST="do"
DEPEND="dev-lang/perl"
