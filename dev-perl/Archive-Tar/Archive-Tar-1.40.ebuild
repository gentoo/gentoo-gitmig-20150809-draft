# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Tar/Archive-Tar-1.40.ebuild,v 1.1 2008/10/20 17:43:02 tove Exp $

MODULE_AUTHOR=KANE
inherit perl-module

DESCRIPTION="A Perl module for creation and manipulation of tar files"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86"
IUSE="bzip2"

DEPEND=">=dev-perl/IO-Zlib-1.01
	>=dev-perl/Compress-Zlib-2.012
	bzip2? ( >=dev-perl/IO-Compress-Bzip2-2.012 )
	dev-perl/IO-String
	perl-core/Package-Constants
	dev-lang/perl"

SRC_TEST="do"

use bzip2 || myconf="-n"
