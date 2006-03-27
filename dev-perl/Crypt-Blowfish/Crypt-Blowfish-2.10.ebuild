# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Blowfish/Crypt-Blowfish-2.10.ebuild,v 1.4 2006/03/27 19:26:21 gustavoz Exp $

inherit perl-module

DESCRIPTION="Crypt::Blowfish module for perl"
HOMEPAGE="http://search.cpan.org/~dparis/${P}"
SRC_URI="mirror://cpan/authors/id/D/DP/DPARIS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~mips ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/libc
	>=dev-lang/perl-5"

export OPTIMIZE="${CFLAGS}"
