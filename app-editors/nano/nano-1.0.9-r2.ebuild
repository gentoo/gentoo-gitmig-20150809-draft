# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nano/nano-1.0.9-r2.ebuild,v 1.5 2003/01/18 18:23:10 tuxus Exp $

DESCRIPTION="clone of Pico with more functions in a smaller size"
SRC_URI="http://www.nano-editor.org/dist/v1.0/${P}.tar.gz"
HOMEPAGE="http://www.nano-editor.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha mips"
IUSE="nls build slang"

DEPEND=">=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )"

PROVIDE="virtual/editor"

src_compile() {
	local myconf="--bindir=/bin --enable-extra"
	use nls   || myconf="${myconf} --disable-nls"
	use build && myconf="${myconf} --disable-wrapping-as-root"

	econf ${myconf}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	use build \
		&& rm -rf ${D}/usr/share \
		|| dodoc COPYING ChangeLog README

	dodir /usr/bin
	dosym /bin/nano /usr/bin/nano
}
