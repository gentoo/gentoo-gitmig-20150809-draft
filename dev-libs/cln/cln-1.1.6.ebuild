# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cln/cln-1.1.6.ebuild,v 1.4 2004/11/04 12:31:25 phosphan Exp $

inherit flag-o-matic gcc

DESCRIPTION="CLN, a class library (C++) for numbers"

HOMEPAGE="http://www.ginac.de/CLN/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ~ppc ~sparc ~amd64"
IUSE=""

SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/gnu/${P}.tar.bz2
	ftp://ftp.santafe.edu/pub/gnu/${P}.tar.bz2
	ftp://ftp.ilog.fr/pub/Users/haible/gnu/${P}.tar.bz2"
DEPEND="dev-libs/gmp"

src_compile() {
	# at least with gcc 2.95 and 3.1, cln won't like -O3 flag...
	replace-flags -O[3..9] -O2

	# and with gcc 2.95.3, it doesn't like funroll-loops as well...
	if [ "$( gcc-fullversion )" == "2.95.3" ]; then
		filter-flags -funroll-loops
		filter-flags -frerun-loop-opt
	fi

	./configure \
		--build=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--datadir=/usr/share/doc/${P} \
		--mandir=/usr/share/man || die "./configure failed"

	#it doesn't also like parallel make :)
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
}
