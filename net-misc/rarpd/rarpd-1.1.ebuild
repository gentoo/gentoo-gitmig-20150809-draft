# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rarpd/rarpd-1.1.ebuild,v 1.1 2002/08/28 21:24:48 murphy Exp $
DESCRIPTION="rarpd - reverse address resolution protocol daemon"
HOMEPAGE="ftp://ftp.dementia.org/pub/net-tools"
SRC_URI="ftp://ftp.dementia.org/pub/net-tools/${P}.tar.gz"
DEPEND=">=net-libs/libnet-1.0.2a
		>=net-libs/libpcap-0.7.1"
S=${WORKDIR}/${P}
KEYWORDS="sparc sparc64"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man  || die

	emake || die
}

src_install () {
	exeinto /usr/sbin
	doexe rarpd
	doman rarpd.8
	dodoc AUTHORS COPYING README TODO VERSION INSTALL
}
