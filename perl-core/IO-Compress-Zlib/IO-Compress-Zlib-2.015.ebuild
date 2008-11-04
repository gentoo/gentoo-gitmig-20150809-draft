# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/IO-Compress-Zlib/IO-Compress-Zlib-2.015.ebuild,v 1.2 2008/11/04 09:42:06 vapier Exp $

MODULE_AUTHOR=PMQS

inherit perl-module

DESCRIPTION="Read/Write compressed files"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="test"

RDEPEND=">=virtual/perl-IO-Compress-Base-${PV}
	>=virtual/perl-Compress-Raw-Zlib-${PV}
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
