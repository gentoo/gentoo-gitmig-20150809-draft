# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freeciv/freeciv-1.14.0-r1.ebuild,v 1.3 2004/01/06 22:14:11 mr_bones_ Exp $

DESCRIPTION="multiplayer strategy game (Civilization Clone)"
HOMEPAGE="http://www.freeciv.org/"
SRC_URI="ftp://ftp.freeciv.org/freeciv/stable/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="X Xaw3d gtk2 nls"

DEPEND="X? ( virtual/x11 )
	Xaw3d? ( x11-libs/Xaw3d )
	gtk? ( ~x11-libs/gtk+-1.2.10-r4
			>=media-libs/imlib-1.9.2
			>=media-libs/libogg-1.0
			>=media-libs/libvorbis-1.0-r2 )
	gtk2? ( >=x11-libs/gtk+-2.0.0
			>=dev-libs/atk-1.0.3
			>=x11-libs/pango-1.2.1-r1
			>=media-libs/libogg-1.0
			>=media-libs/libvorbis-1.0-r2 )"
RDEPEND="sys-libs/zlib"

src_compile() {
	local myconf

	myconf="${myconf} --enable-client=no"

	use X \
		&& myconf="${myconf} --enable-client=xaw --with-x"

	use Xaw3d \
		&& myconf="${myconf} --enable-client=xaw3d --disable-gtktest"

	if [ `use gtk2` ] ; then
		myconf="${myconf} --enable-client=gtk-2.0 --enable-gtktest"
	elif [ `use gtk` ] ; then
		myconf="${myconf} --enable-client=gtk --enable-gtktest"
	fi

	use nls \
		|| myconf="${myconf} --disable-nls"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-zlib \
	${myconf} || die
	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		install	|| die

	use gtk	|| use gtk2 ||  /bin/install -D -m 644 \
		${S}/data/Freeciv \
		${D}/usr/X11R6/lib/X11/app-defaults/Freeciv


	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog HOWTOPLAY INSTALL NEWS PEOPLE README*
	dodoc TODO freeciv_hackers_guide.txt
}
