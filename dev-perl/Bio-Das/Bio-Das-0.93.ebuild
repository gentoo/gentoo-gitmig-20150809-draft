# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bio-Das/Bio-Das-0.93.ebuild,v 1.5 2005/03/23 19:19:14 mcummings Exp $

inherit perl-module

DEPEND=">=dev-perl/Compress-Zlib-1.0
	>=dev-perl/HTML-Parser-3
	>=dev-perl/libwww-perl-5
	>=dev-perl/MIME-Base64-2.12
	"

DESCRIPTION="Interface to Distributed Annotation System"
SRC_URI="http://search.cpan.org/CPAN/authors/id/L/LD/LDS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~lds/${P}/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~ppc"
