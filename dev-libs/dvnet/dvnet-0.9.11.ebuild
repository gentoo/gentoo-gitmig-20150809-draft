# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvnet/dvnet-0.9.11.ebuild,v 1.2 2005/06/05 12:24:18 hansmi Exp $

DESCRIPTION="dvnet provides an interface wrapping sockets into streams"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvnet/html/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvnet/download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86"

IUSE=""

DEPEND="virtual/libc
	dev-libs/dvutil"

src_install() {
	#make DESTDIR=${D} prefix=${D}/usr install
	make DESTDIR=${D} install || die "error in make install"
}
