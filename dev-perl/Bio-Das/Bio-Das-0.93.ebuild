# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bio-Das/Bio-Das-0.93.ebuild,v 1.1 2004/01/09 21:27:06 sediener Exp $

inherit perl-module

DEPEND=">=Compress-Zlib-1.0
	>=HTML-Parser-3
	>=libwww-perl-5
	>=MIME-Base64-2.12
	"

DESCRIPTION="Interface to Distributed Annotation System"
SRC_URI="http://search.cpan.org/CPAN/authors/id/L/LD/LDS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~lds/${P}/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86"
