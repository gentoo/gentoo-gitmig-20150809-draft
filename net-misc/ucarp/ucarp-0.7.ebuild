# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ucarp/ucarp-0.7.ebuild,v 1.5 2005/01/29 21:26:23 dragonheart Exp $

DESCRIPTION="Userspace CARP implementation allows hosts to share ip address."

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
