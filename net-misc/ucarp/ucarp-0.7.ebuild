# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ucarp/ucarp-0.7.ebuild,v 1.2 2004/07/15 00:14:35 agriffis Exp $

DESCRIPTION="Userspace CARP implimentation allows hosts to share ip address."

HOMEPAGE="http://www.ucarp.org/"
SRC_URI="http://www.pureftpd.org/ucarp/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=net-libs/libpcap-0.8.3-r1"

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
