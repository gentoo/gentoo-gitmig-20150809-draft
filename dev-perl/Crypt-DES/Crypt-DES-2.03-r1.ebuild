# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-DES/Crypt-DES-2.03-r1.ebuild,v 1.17 2005/10/02 12:30:57 agriffis Exp $

inherit perl-module

DESCRIPTION="Crypt::DES module for perl"
HOMEPAGE="http://search.cpan.org/author/DPARIS/Crypt-DES-${PV}/"
SRC_URI="mirror://cpan/authors/id/D/DP/DPARIS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/libc
	>=dev-lang/perl-5"

export OPTIMIZE="${CFLAGS}"
