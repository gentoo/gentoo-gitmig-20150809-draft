# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Archive-Tar/Archive-Tar-1.40.ebuild,v 1.4 2009/04/18 16:10:45 tove Exp $

MODULE_AUTHOR=KANE
inherit perl-module

DESCRIPTION="A Perl module for creation and manipulation of tar files"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="bzip2"

DEPEND=">=virtual/perl-IO-Zlib-1.01
	>=virtual/perl-Compress-Zlib-2.012
	bzip2? ( >=virtual/perl-IO-Compress-Bzip2-2.012 )
	dev-perl/IO-String
	perl-core/Package-Constants
	dev-lang/perl"

SRC_TEST="do"

use bzip2 || myconf="-n"
