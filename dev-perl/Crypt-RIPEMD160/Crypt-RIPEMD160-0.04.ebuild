# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-RIPEMD160/Crypt-RIPEMD160-0.04.ebuild,v 1.10 2005/08/25 22:49:40 agriffis Exp $

inherit perl-module

DESCRIPTION="Crypt::RIPEMD160 module for perl"
HOMEPAGE="http://search.cpan.org/~chgeuer/${P}"
SRC_URI="mirror://cpan/authors/id/C/CH/CHGEUER/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
IUSE=""

export OPTIMIZE="$CFLAGS"
