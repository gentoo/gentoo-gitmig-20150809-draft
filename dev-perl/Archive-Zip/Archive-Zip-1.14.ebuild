# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Zip/Archive-Zip-1.14.ebuild,v 1.7 2005/03/29 18:32:38 corsair Exp $

inherit perl-module

DESCRIPTION="A wrapper that lets you read Zip archive members as if they were files"
HOMEPAGE="http://search.cpan.org/~nedkonz/${P}/"
SRC_URI="mirror://cpan/authors/id/N/NE/NEDKONZ/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 sparc ppc alpha amd64 ppc64 ~mips"
IUSE=""
SRC_TEST="do"

DEPEND=">=dev-perl/Compress-Zlib-1.14"
