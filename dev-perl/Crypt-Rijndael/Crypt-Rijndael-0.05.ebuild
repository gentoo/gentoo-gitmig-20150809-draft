# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Rijndael/Crypt-Rijndael-0.05.ebuild,v 1.6 2006/04/21 21:05:18 gustavoz Exp $

inherit perl-module

DESCRIPTION="Crypt::CBC compliant Rijndael encryption module"
HOMEPAGE="http://search.cpan.org/~dido/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DI/DIDO/${P}.tar.gz"


LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="hppa ~ia64 sparc x86"
IUSE=""

SRC_TEST="do"
