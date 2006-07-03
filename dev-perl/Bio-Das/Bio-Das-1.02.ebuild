# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bio-Das/Bio-Das-1.02.ebuild,v 1.4 2006/07/03 20:25:07 ian Exp $

inherit perl-module


DESCRIPTION="Interface to Distributed Annotation System"
SRC_URI="mirror://cpan/authors/id/L/LD/LDS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~lds/Bio-Das-1.02/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~ia64 ~ppc ~sparc ~x86"

SRC_TEST="do"

DEPEND=">=dev-perl/Compress-Zlib-1.0
	sci-biology/bioperl
	>=dev-perl/HTML-Parser-3
	>=dev-perl/libwww-perl-5
	>=virtual/perl-MIME-Base64-2.12"
RDEPEND="${DEPEND}"