# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/newspost/newspost-2.1.ebuild,v 1.4 2004/03/20 07:32:10 mr_bones_ Exp $

DESCRIPTION="a usenet binary autoposter for unix"
HOMEPAGE="http://newspost.unixcab.org/"
SRC_URI="http://newspost.unixcab.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

# NOTE: This package should work on PPC but not tested!
# It also has a solaris make file but we don't do solaris.
# but it should mean that it is 64bit clean.
KEYWORDS="x86"

DEPEND="sys-libs/glibc sys-devel/gcc"
RDEPEND="sys-libs/glibc"

S=${WORKDIR}/${P}

src_unpack() {
	unpack $A
	cd $S
	cp Makefile Makefile.orig
	sed -e "s:OPT_FLAGS = :OPT_FLAGS = ${CFLAGS}#:" Makefile.orig > Makefile
}

src_compile() {
	emake || die
}

src_install () {
	dobin newspost
	doman man/man1/newspost.1
	dodoc README
	dodoc CHANGES
	dodoc COPYING
}
