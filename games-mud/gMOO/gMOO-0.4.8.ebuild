# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gMOO/gMOO-0.4.8.ebuild,v 1.1 2003/09/10 19:03:12 vapier Exp $

IUSE="nls tcltk"

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ Based MOO client"
SRC_URI="http://www.nowmoo.demon.nl/packages/${P}.tar.gz"
HOMEPAGE="http://www.nowmoo.demon.nl/"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

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

	./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} ${myconf} || die

	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README INSTALL COPYING VERSION NEWS TODO ChangeLog ABOUT-NLS
}
