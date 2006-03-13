# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-cbc/crypt-cbc-2.17.ebuild,v 1.2 2006/03/13 20:04:20 gustavoz Exp $

inherit perl-module

MY_P=Crypt-CBC-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Encrypt Data with Cipher Block Chaining Mode"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/L/LD/LDS/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/L/LD/LDS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~mips ~ppc ~ppc64 sparc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="virtual/perl-Digest-MD5"
