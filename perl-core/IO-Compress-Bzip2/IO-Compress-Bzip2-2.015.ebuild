# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/IO-Compress-Bzip2/IO-Compress-Bzip2-2.015.ebuild,v 1.1 2009/04/18 10:43:46 tove Exp $

MODULE_AUTHOR=PMQS
inherit perl-module

DESCRIPTION="Read and write bzip2 files/buffers"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND="~virtual/perl-Compress-Raw-Bzip2-${PV}
	~virtual/perl-IO-Compress-Base-${PV}"
RDEPEND="${DEPEND}"

SRC_TEST=do
