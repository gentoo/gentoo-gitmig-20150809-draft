# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-DES/Crypt-DES-2.03.ebuild,v 1.10 2004/07/02 04:59:31 eradicator Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Crypt::DES module for perl"
SRC_URI="http://www.cpan.org/authors/id/D/DP/DPARIS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/DPARIS/Crypt-DES-${PV}/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc alpha"

DEPEND="virtual/libc >=dev-lang/perl-5"

export OPTIMIZE="${CFLAGS}"
