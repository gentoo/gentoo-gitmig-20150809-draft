# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/nano/nano-1.0.9.ebuild,v 1.1 2002/09/25 23:41:47 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="clone of Pico with more functions in a smaller size"
SRC_URI="http://www.nano-editor.org/dist/v1.0/${P}.tar.gz"
HOMEPAGE="http://www.nano-editor.org/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	slang? ( >=sys-libs/slang-1.4.4-r1 )
	nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

src_compile() {
	local myconf

	use slang && myconf="${myconf} --with-slang"
	use nls   || myconf="${myconf} --disable-nls"
	
	if use bootcd || use build ; then
		myconf="${myconf} --disable-wrapping-as-root"
	fi

	./configure \
		--build=${CHOST} \
		--prefix=/usr \
		--enable-extra \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		${myconf} || die "./configure failed"

	emake || die
}

src_install () {
	make 	\
		DESTDIR=${D} 	\
		install || die

	if use bootcd || use build; then
		rm -rf ${D}/usr/share
	else
		dodoc COPYING ChangeLog README
	fi
}
