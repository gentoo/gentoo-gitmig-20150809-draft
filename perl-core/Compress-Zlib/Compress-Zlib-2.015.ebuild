# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Compress-Zlib/Compress-Zlib-2.015.ebuild,v 1.1 2008/11/02 07:19:04 tove Exp $

MODULE_AUTHOR=PMQS

inherit perl-module

DESCRIPTION="A Zlib perl module"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="test"

RDEPEND="sys-libs/zlib
	>=virtual/perl-Compress-Raw-Zlib-${PV}
	>=virtual/perl-IO-Compress-Base-${PV}
	>=virtual/perl-IO-Compress-Zlib-${PV}
	virtual/perl-Scalar-List-Utils
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"

mydoc="TODO"
