# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gMOO/gMOO-0.4.8-r1.ebuild,v 1.2 2004/01/24 13:51:27 mr_bones_ Exp $


DESCRIPTION="GTK+ Based MOO client"
HOMEPAGE="http://www.nowmoo.demon.nl/"
SRC_URI="http://www.nowmoo.demon.nl/packages/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls tcltk"

DEPEND="virtual/glibc
	>=x11-base/xfree-4.1.0
	=x11-libs/gtk+-1.2*
	tcltk? ( dev-lang/tcl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	use nls && patch -l -p0 <${FILESDIR}/gMOO.patch
}

src_compile() {
	local myconf=""

	use tcltk || myconf="${myconf} --disable-tcl"

	use nls	|| myconf="${myconf} --disable-nls"

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} ${myconf} || die "configure failed"

	make || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README INSTALL VERSION NEWS TODO ChangeLog || die "dodoc failed"
}
