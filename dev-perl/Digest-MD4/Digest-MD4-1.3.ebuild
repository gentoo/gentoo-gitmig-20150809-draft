# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-MD4/Digest-MD4-1.3.ebuild,v 1.6 2004/07/29 04:04:56 vapier Exp $

inherit perl-module

AUTHOR="MIKEM"
BASE_URI="http://search.cpan.org/CPAN/authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}/"
DESCRIPTION="MD4 message digest algorithm"
HOMEPAGE="${BASE_URI}/${P}.readme"
SRC_URI="${BASE_URI}/Authen/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc mips arm hppa"
IUSE=""

SRC_TEST="do"
mydoc="README Changes"
