# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/httptunnel/httptunnel-3.3.ebuild,v 1.8 2009/01/08 18:56:37 jer Exp $

DESCRIPTION="httptunnel can create IP tunnels through firewalls/proxies using HTTP"
HOMEPAGE="http://www.nocrew.org/software/httptunnel.html"
LICENSE="GPL-2"
DEPEND=""
KEYWORDS="~amd64 ppc sparc x86 ~x86-fbsd"
IUSE=""
SLOT="0"
#RDEPEND=""
SRC_URI="http://www.nocrew.org/software/httptunnel/${P}.tar.gz"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die
}
