# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-RIPEMD160/Crypt-RIPEMD160-0.04.ebuild,v 1.8 2005/04/21 18:55:55 hansmi Exp $

inherit perl-module

DESCRIPTION="Crypt::RIPEMD160 module for perl"
HOMEPAGE="http://cpan.pair.com/authors/id/C/CH/CHGEUER/"
SRC_URI="http://cpan.pair.com/authors/id/C/CH/CHGEUER/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

export OPTIMIZE="$CFLAGS"
