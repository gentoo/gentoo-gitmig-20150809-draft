# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Blowfish/Crypt-Blowfish-2.09-r2.ebuild,v 1.2 2002/05/21 18:14:07 danarmak Exp $

# Inherit the perl-module.eclass functions

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Crypt::Blowfish module for perl"
SRC_URI="http://www.cpan.org/authors/id/D/DP/DPARIS/${P}.tar.gz"
DEPEND="virtual/glibc >=sys-devel/perl-5"
LICENSE="Artistic | GPL-2"
SLOT="0"

export OPTIMIZE="${CFLAGS}"
