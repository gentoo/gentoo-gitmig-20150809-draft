# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libezV24/libezV24-0.1.1.ebuild,v 1.2 2004/04/21 16:42:16 vapier Exp $

inherit eutils

DESCRIPTION="library that provides an easy API to Linux serial ports"
HOMEPAGE="http://ezv24.sourceforge.net/"
SRC_URI="mirror://sourceforge/ezv24/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -ppc ~sparc ~alpha"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	epatch ${FILESDIR}/${P}-test-v24.c.diff
	epatch ${FILESDIR}/${P}-Makefile.diff
	emake || die "Make failed"
}

src_install() {
	make install PREFIX=${D}usr || die "Make install failed"
	dodoc AUTHORS BUGS ChangeLog HISTORY README
	dohtml api-html/*

	# make install makes symlinks that don't exist when installed, so
	# replace them and re-create with dosym

	rm ${D}/usr/lib/libezV24.so
	rm ${D}/usr/lib/libezV24.so.0

	dosym libezV24.so.0.1 /usr/lib/libezV24.so.0
	dosym libezV24.so.0 /usr/lib/libezV24.so
}
