# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-RIPEMD160/Crypt-RIPEMD160-0.03-r3.ebuild,v 1.1 2002/10/30 07:20:35 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Crypt::RIPEMD160 module for perl"
HOMEPAGE="http://www.cpan.org/authors/id/C/CH/CHGEUER/"
SRC_URI="http://www.cpan.org/authors/id/C/CH/CHGEUER/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

export OPTIMIZE="$CFLAGS"
