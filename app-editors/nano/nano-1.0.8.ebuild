# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Parag Mehta <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/nano/nano-1.0.8.ebuild,v 1.1 2002/02/20 16:09:43 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="clone of Pico with more functions in a smaller size"
SRC_URI="http://www.nano-editor.org/dist/v1.0/${P}.tar.gz"
HOMEPAGE="http://www.nano-editor.org/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	slang? ( >=sys-libs/slang-1.4.4-r1 )"

src_compile() {
	local myflags
	if use slang; then
		myflags="--with-slang"
	else
		myflags="--without-slang"
	fi
	./configure \
		--build=${CHOST} \
		--prefix=/usr \
		--enable-extra \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		${myflags} || die "./configure failed"
	emake || die
}

src_install () {
    make DESTDIR=${D} install || die
	if use bootcd || use build; then
		rm -rf ${D}/usr/share
	else
		dodoc COPYING ChangeLog README
	fi
}
