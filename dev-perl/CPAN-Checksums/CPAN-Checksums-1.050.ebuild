# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CPAN-Checksums/CPAN-Checksums-1.050.ebuild,v 1.11 2009/07/19 17:34:19 tove Exp $

inherit perl-module

DESCRIPTION="Write a CHECKSUMS file for a directory as on CPAN"
HOMEPAGE="http://search.cpan.org/~andk/"
SRC_URI="mirror://cpan/authors/id/A/AN/ANDK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Data-Compare
		virtual/perl-IO-Compress
		dev-perl/Compress-Bzip2
		virtual/perl-Digest-SHA
		virtual/perl-File-Temp
		virtual/perl-Digest-MD5
	dev-lang/perl"
