# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nano/nano-1.0.9-r1.ebuild,v 1.1 2002/11/30 10:58:06 mkennedy Exp $

DESCRIPTION="clone of Pico with more functions in a smaller size"
SRC_URI="http://www.nano-editor.org/dist/v1.0/${P}.tar.gz"
HOMEPAGE="http://www.nano-editor.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"
IUSE="nls build slang"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf="--bindir=/bin --enable-extra"

	use nls   || myconf="${myconf} --disable-nls"
	
	if use build ; then
		myconf="${myconf} --disable-wrapping-as-root"
	fi

	econf ${myconf}
	emake || die
}

src_install () {
	make \
		DESTDIR=${D} \
		install || die

	if use build; then
		rm -rf ${D}/usr/share
	else
		dodoc COPYING ChangeLog README
	fi
}
