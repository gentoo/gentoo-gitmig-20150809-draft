# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freeciv/freeciv-1.13.0.ebuild,v 1.1 2003/09/10 05:27:31 vapier Exp $

DESCRIPTION="multiplayer strategy game (Civilization Clone)"
SRC_URI="ftp://ftp.freeciv.org/freeciv/stable/${P}.tar.bz2"
HOMEPAGE="http://www.freeciv.org/"

KEYWORDS="x86 sparc"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls gtk imlib"

DEPEND="virtual/x11
	|| (
		gtk? ( ~x11-libs/gtk+-1.2.10-r4 )
		x11-libs/xaw
	)
	imlib? ( >=media-libs/imlib-1.9.10-r1 )"
RDEPEND="sys-libs/zlib"

src_compile() {
	local myconf

	use gtk \
		|| myconf="${myconf} --with-xaw3d --disable-gtktest"

	use imlib \
		|| myconf="${myconf} --disable-imlibtest"

	use nls \
		|| myconf="${myconf} --disable-nls"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-x \
		--with-zlib \
		${myconf} || die

	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		install	|| die

	use gtk	|| /bin/install -D -m 644 \
		${S}/data/Freeciv \
		${D}/usr/X11R6/lib/X11/app-defaults/Freeciv


	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog HOWTOPLAY INSTALL NEWS PEOPLE README*
	dodoc TODO freeciv_hackers_guide.txt
}
