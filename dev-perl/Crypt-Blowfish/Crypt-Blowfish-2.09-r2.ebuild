# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Blowfish/Crypt-Blowfish-2.09-r2.ebuild,v 1.4 2002/07/23 22:29:48 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Crypt::Blowfish module for perl"
SRC_URI="http://www.cpan.org/authors/id/D/DP/DPARIS/${P}.tar.gz"
DEPEND="virtual/glibc >=sys-devel/perl-5"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"

export OPTIMIZE="${CFLAGS}"
