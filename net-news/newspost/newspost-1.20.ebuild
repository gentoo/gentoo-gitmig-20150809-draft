# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/newspost/newspost-1.20.ebuild,v 1.6 2004/06/21 00:51:43 swegener Exp $

DESCRIPTION="a usenet binary autoposter for unix"
HOMEPAGE="http://newspost.unixcab.org/"
SRC_URI="http://newspost.unixcab.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

# NOTE: This package should work on PPC but not tested!
# It also has a solaris make file but we don't do solaris.
# but it should mean that it is 64bit clean.
KEYWORDS="x86"

DEPEND="sys-libs/glibc sys-devel/gcc"

src_unpack() {
	unpack $A
	cd $S
	cp Makefile Makefile.orig
	sed -e "s:CFLAGS = :CFLAGS = ${CFLAGS}#:" Makefile.orig > Makefile
}

src_compile() {
	emake || die
}

src_install () {
	dobin newspost
	dodoc README
	dodoc CHANGES
	dodoc COPYING
}
