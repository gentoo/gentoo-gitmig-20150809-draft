# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/IO-Compress/IO-Compress-2.020.ebuild,v 1.4 2009/06/19 00:23:12 ranger Exp $

EAPI=2

MODULE_AUTHOR=PMQS
inherit perl-module

DESCRIPTION="allow reading and writing of compressed data"

SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 m68k ~mips ~ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/perl-Scalar-List-Utils
	>=virtual/perl-Compress-Raw-Zlib-${PV}
	>=virtual/perl-Compress-Raw-Bzip2-${PV}"
RDEPEND="${DEPEND}
	!perl-core/Compress-Zlib
	!perl-core/IO-Compress-Zlib
	!perl-core/IO-Compress-Bzip2
	!perl-core/IO-Compress-Base
	!<virtual/perl-Compress-Zlib-2.017
	!<virtual/perl-IO-Compress-Zlib-2.017
	!<virtual/perl-IO-Compress-Bzip2-2.017
	!<virtual/perl-IO-Compress-Base-2.017"
#DEPEND="${DEPEND}
#	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
