# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Blowfish/Crypt-Blowfish-2.09-r3.ebuild,v 1.8 2004/02/26 06:09:59 kumba Exp $

inherit perl-module

DESCRIPTION="Crypt::Blowfish module for perl"
HOMEPAGE="http://search.cpan.org/author/DPARIS/Crypt-Blowfish-${PV}/"
SRC_URI="http://www.cpan.org/authors/id/D/DP/DPARIS/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ~mips"

DEPEND="virtual/glibc
	>=dev-lang/perl-5"

export OPTIMIZE="${CFLAGS}"
