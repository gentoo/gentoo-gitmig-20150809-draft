# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Compress-Raw-Bzip2/Compress-Raw-Bzip2-2.015.ebuild,v 1.10 2008/12/10 17:12:51 aballier Exp $

MODULE_AUTHOR=PMQS
inherit perl-module

DESCRIPTION="Low-Level Interface to bzip2 compression library"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="test"

RDEPEND="dev-lang/perl
	app-arch/bzip2"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do

src_compile(){
	BUILD_BZIP2=0 BZIP2_INCLUDE= BZIP2_LIB= \
		perl-module_src_compile
}
