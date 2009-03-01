# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PerlIO-gzip/PerlIO-gzip-0.18.ebuild,v 1.1 2009/03/01 10:48:08 pva Exp $

inherit perl-module

DESCRIPTION="PerlIO::Gzip - PerlIO layer to gzip/gunzip"
HOMEPAGE="http://search.cpan.org/~nwclark/PerlIO-gzip/"
SRC_URI="mirror://cpan/authors/id/N/NW/NWCLARK/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=dev-lang/perl-5.8
		sys-libs/zlib"
RDEPEND="${DEPEND}"
