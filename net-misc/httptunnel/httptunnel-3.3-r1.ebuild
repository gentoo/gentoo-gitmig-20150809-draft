# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/httptunnel/httptunnel-3.3-r1.ebuild,v 1.3 2012/02/24 19:28:14 ranger Exp $

inherit eutils

DESCRIPTION="httptunnel can create IP tunnels through firewalls/proxies using HTTP"
HOMEPAGE="http://www.nocrew.org/software/httptunnel.html"
LICENSE="GPL-2"
DEPEND=""
KEYWORDS="~amd64 ppc ~sparc x86 ~x86-fbsd"
IUSE=""
SLOT="0"
#RDEPEND=""
SRC_URI="http://www.nocrew.org/software/httptunnel/${P}.tar.gz"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-fix_write_stdin.patch
}

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
