# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: tools@cvs.gentoo.org
# $Header: /var/cvsroot/gentoo-x86/app-editors/e3/e3-1.7-r2.ebuild,v 1.5 2001/08/18 03:22:30 chadh Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Super Tiny Editor with wordstar, vi, and emacs key bindings"
SRC_URI="http://www.sax.de/~adlibit/${P}.tar.gz"
HOMEPAGE="http://www.sax.de/~adlibit"
DEPEND="sys-devel/gcc
	>=sys-apps/gzip-1.2.4a-r6"
RDEPEND="sys-apps/sed"

src_compile() {
	cd e3c
	emake || die
}

src_install () {
	cp e3.man e3.1
	doman e3.1

	cd e3c
	mv e3c e3
	dodir /usr/bin
	dobin e3
	dosym e3 /usr/bin/e3vi
	dosym e3 /usr/bin/e3em
	dosym e3 /usr/bin/e3ws
	dosym e3 /usr/bin/e3pi
	dosym e3 /usr/bin/e3ne

}

