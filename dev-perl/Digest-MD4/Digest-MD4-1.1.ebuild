# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-MD4/Digest-MD4-1.1.ebuild,v 1.8 2004/09/06 16:54:22 pvdabeel Exp $

inherit perl-module

DESCRIPTION="MD4 message digest algorithm"
AUTHOR="MIKEM"
BASE_URI="http://search.cpan.org/CPAN/authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}/"
HOMEPAGE="${BASE_URI}/${P}.readme"
SRC_URI="${BASE_URI}/${P}.tar.gz"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 sparc ~hppa ~mips ppc"
IUSE=""
mydoc="README Changes"
