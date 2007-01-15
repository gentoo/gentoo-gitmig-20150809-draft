# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Blowfish/Crypt-Blowfish-2.09-r3.ebuild,v 1.17 2007/01/15 15:29:39 mcummings Exp $

inherit perl-module

DESCRIPTION="Crypt::Blowfish module for perl"
HOMEPAGE="http://search.cpan.org/~dparis/"
SRC_URI="mirror://cpan/authors/id/D/DP/DPARIS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86"
IUSE=""

DEPEND="virtual/libc
	>=dev-lang/perl-5"

export OPTIMIZE="${CFLAGS}"
