# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-MD4/Digest-MD4-1.1.ebuild,v 1.6 2004/06/25 00:24:56 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="MD4 message digest algorithm"
AUTHOR="MIKEM"
BASE_URI="http://search.cpan.org/CPAN/authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}/"
HOMEPAGE="${BASE_URI}/${P}.readme"
SRC_URI="${BASE_URI}/${P}.tar.gz"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 sparc ~hppa ~mips"
mydoc="README Changes"
