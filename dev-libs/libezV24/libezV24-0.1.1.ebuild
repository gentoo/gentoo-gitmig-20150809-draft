# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libezV24/libezV24-0.1.1.ebuild,v 1.1 2003/11/19 20:12:23 weeve Exp $

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="libezV24 - library that provides an easy API to Linux serial ports"
HOMEPAGE="http://ezv24.sf.net"
SRC_URI="mirror://sourceforge/ezv24/${P}.tar.gz"
DEPEND=""
RDEPEND=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc ~sparc ~alpha"

src_compile() {
	epatch ${FILESDIR}/${P}-test-v24.c.diff
	epatch ${FILESDIR}/${P}-Makefile.diff
	emake || die "Make failed"
}

src_install() {
	make install PREFIX=${D}usr || die "Make install failed"
	dodoc AUTHORS BUGS COPYING ChangeLog HISTORY README
	dohtml api-html/*

	# make install makes symlinks that don't exist when installed, so
	# replace them and re-create with dosym

	rm ${D}/usr/lib/libezV24.so
	rm ${D}/usr/lib/libezV24.so.0

	dosym libezV24.so.0.1 /usr/lib/libezV24.so.0
	dosym libezV24.so.0 /usr/lib/libezV24.so
}
