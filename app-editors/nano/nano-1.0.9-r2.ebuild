# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nano/nano-1.0.9-r2.ebuild,v 1.8 2004/03/17 01:46:14 vapier Exp $

DESCRIPTION="clone of Pico with more functions in a smaller size"
HOMEPAGE="http://www.nano-editor.org/"
SRC_URI="http://www.nano-editor.org/dist/v1.0/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips hppa"
IUSE="nls build"

DEPEND=">=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )"

PROVIDE="virtual/editor"

src_compile() {
	local myconf="--bindir=/bin --enable-extra"
	use nls   || myconf="${myconf} --disable-nls"
	use build && myconf="${myconf} --disable-wrapping-as-root"

	econf ${myconf} || die
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
