# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/httptunnel/httptunnel-3.0.5.ebuild,v 1.8 2004/06/26 12:13:09 dholm Exp $

S=${WORKDIR}/${P}
DESCRIPTION="httptunnel can create IP tunnels through firewalls/proxies using HTTP"
HOMEPAGE="http://www.nocrew.org/software/httptunnel.html"
LICENSE="GPL-2"
DEPEND=""
KEYWORDS="x86 sparc ~ppc"
SLOT="0"
#RDEPEND=""
SRC_URI="http://www.nocrew.org/software/httptunnel/httptunnel-3.0.5.tar.gz"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
