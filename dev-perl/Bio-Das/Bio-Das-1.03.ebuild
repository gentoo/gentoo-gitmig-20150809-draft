# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bio-Das/Bio-Das-1.03.ebuild,v 1.3 2008/11/18 14:25:06 tove Exp $

inherit perl-module

DESCRIPTION="Interface to Distributed Annotation System"
SRC_URI="mirror://cpan/authors/id/L/LD/LDS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~lds/Bio-Das-1.02/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"

SRC_TEST="do"

DEPEND=">=virtual/perl-Compress-Zlib-1.0
	sci-biology/bioperl
	>=dev-perl/HTML-Parser-3
	>=dev-perl/libwww-perl-5
	>=virtual/perl-MIME-Base64-2.12
	dev-lang/perl"
