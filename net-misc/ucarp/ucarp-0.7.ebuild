# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ucarp/ucarp-0.7.ebuild,v 1.7 2006/09/17 22:26:28 xmerlin Exp $


DESCRIPTION="Portable userland implementation of Common Address Redundancy Protocol (CARP)."

HOMEPAGE="http://www.ucarp.org/"
SRC_URI="http://www.pureftpd.org/ucarp/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="virtual/libpcap"

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die "emake failed"
}

src_install() {

	make DESTDIR=${D} install-strip || die

}
