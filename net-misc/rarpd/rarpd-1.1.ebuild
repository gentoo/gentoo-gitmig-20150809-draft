# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rarpd/rarpd-1.1.ebuild,v 1.3 2002/09/05 16:25:16 drobbins Exp $
DESCRIPTION="rarpd - reverse address resolution protocol daemon"
HOMEPAGE="ftp://ftp.dementia.org/pub/net-tools"
SRC_URI="ftp://ftp.dementia.org/pub/net-tools/${P}.tar.gz"
DEPEND="<net-libs/libnet-1.1
		>=net-libs/libpcap-0.7.1"
S=${WORKDIR}/${P}
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="as-is"

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
