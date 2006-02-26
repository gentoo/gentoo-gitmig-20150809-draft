# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-OpenSSL-Bignum/Crypt-OpenSSL-Bignum-0.03.ebuild,v 1.3 2006/02/26 19:45:38 kumba Exp $

inherit perl-module

DESCRIPTION="OpenSSL's multiprecision integer arithmetic"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/I/IR/IROBERTS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~mips ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"
