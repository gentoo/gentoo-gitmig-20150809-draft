# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-DES/Crypt-DES-2.03.ebuild,v 1.2 2002/08/16 22:22:24 gerk Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Crypt::DES module for perl"
SRC_URI="http://www.cpan.org/authors/id/D/DP/DPARIS/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc >=sys-devel/perl-5"

export OPTIMIZE="${CFLAGS}"
