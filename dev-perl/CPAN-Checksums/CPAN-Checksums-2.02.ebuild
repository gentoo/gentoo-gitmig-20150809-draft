# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CPAN-Checksums/CPAN-Checksums-2.02.ebuild,v 1.1 2008/10/31 17:13:32 tove Exp $

MODULE_AUTHOR=ANDK
inherit perl-module

DESCRIPTION="Write a CHECKSUMS file for a directory as on CPAN"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE="test"

RDEPEND="dev-perl/Compress-Zlib
	dev-perl/Compress-Bzip2
	dev-perl/Data-Compare
	dev-perl/Digest-SHA
	virtual/perl-Digest-MD5
	virtual/perl-File-Temp
	virtual/perl-IO
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
