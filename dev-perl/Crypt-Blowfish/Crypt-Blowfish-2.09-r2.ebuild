# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Blowfish/Crypt-Blowfish-2.09-r2.ebuild,v 1.17 2004/07/02 04:59:18 eradicator Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Crypt::Blowfish module for perl"
SRC_URI="http://www.cpan.org/authors/id/D/DP/DPARIS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/DPARIS/Crypt-Blowfish-${PV}/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="virtual/libc >=dev-lang/perl-5"

export OPTIMIZE="${CFLAGS}"
