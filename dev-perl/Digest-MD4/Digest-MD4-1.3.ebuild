# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-MD4/Digest-MD4-1.3.ebuild,v 1.5 2004/07/28 04:53:49 kumba Exp $

inherit perl-module

DESCRIPTION="MD4 message digest algorithm"
AUTHOR="MIKEM"
BASE_URI="http://search.cpan.org/CPAN/authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}/"
HOMEPAGE="${BASE_URI}/${P}.readme"
SRC_URI="${BASE_URI}/Authen/${P}.tar.gz"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~sparc ~hppa mips ~ppc"
IUSE=""
SRC_TEST="do"
mydoc="README Changes"
