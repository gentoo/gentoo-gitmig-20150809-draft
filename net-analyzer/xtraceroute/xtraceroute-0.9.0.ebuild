# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/xtraceroute/xtraceroute-0.9.0.ebuild,v 1.4 2002/07/18 23:22:52 seemant Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="neat graphical traceroute displaying route on the globe"
SRC_URI="http://www.dtek.chalmers.se/~d3august/xt/dl/${P}.tar.gz
	http://www.dtek.chalmers.se/~d3august/xt/dl/ndg_files.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/~d3august/xt/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="x11-base/xfree
	=x11-libs/gtk+-1.2*
	net-analyzer/traceroute
	<x11-libs/gtkglarea-1.99.0
	media-libs/gdk-pixbuf
	net-misc/host"

RDEPEND="${DEPEND}"


src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--with-host=/usr/bin/hostx \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	
	emake || die
	#make || die
}

src_install () {
	#make DESTDIR=${D} install || die
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	# Install documentation.
	dodoc AUTHORS  COPYING INSTALL NEWS README TODO

	#Install NDG loc database
	cd ${D}/usr/share/xtraceroute/
	unpack "ndg_files.tar.gz"
}
