# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Archive-Tar/Archive-Tar-1.38.ebuild,v 1.3 2009/04/18 16:10:45 tove Exp $

inherit perl-module

DESCRIPTION="A Perl module for creation and manipulation of tar files"
HOMEPAGE="http://search.cpan.org/~kane/Archive-Tar/"
SRC_URI="mirror://cpan/authors/id/K/KA/KANE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~mips"
IUSE=""

DEPEND="virtual/perl-IO-Zlib
	dev-perl/IO-String
	dev-lang/perl"

SRC_TEST="do"
