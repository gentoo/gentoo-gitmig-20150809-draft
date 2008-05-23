# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cln/cln-1.2.2.ebuild,v 1.1 2008/05/23 10:37:53 bicatali Exp $

inherit flag-o-matic toolchain-funcs multilib

DESCRIPTION="CLN, a class library (C++) for numbers"

HOMEPAGE="http://www.ginac.de/CLN/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/gnu/${P}.tar.bz2
	ftp://ftp.santafe.edu/pub/gnu/${P}.tar.bz2
	ftp://ftp.ilog.fr/pub/Users/haible/gnu/${P}.tar.bz2"
DEPEND="dev-libs/gmp"

src_compile () {
	# -Os causes segmentation faults (see bug #174576)
	# checked for 1.2.1, gcc-4.2.3
	replace-flags -Os -O2

	econf  \
		--libdir=/usr/$(get_libdir) \
		--datadir=/usr/share/doc/${PF} || die "econf failed."
	emake || die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
}
