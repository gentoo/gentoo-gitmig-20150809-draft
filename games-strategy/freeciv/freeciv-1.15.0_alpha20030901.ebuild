# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freeciv/freeciv-1.15.0_alpha20030901.ebuild,v 1.1 2003/09/10 05:27:31 vapier Exp $

inherit games

S="${WORKDIR}/freeciv-cvs-Sep-01"
DESCRIPTION="multiplayer strategy game (Civilization Clone)"
HOMEPAGE="http://www.freeciv.org/"
SRC_URI="ftp://ftp.freeciv.org/freeciv/latest/freeciv-cvs-Sep-01.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="X Xaw3d gtk gtk2 sdl nls"

DEPEND=">=sys-devel/gettext-0.10.36
	>=sys-devel/autoconf-2.13
	>=sys-devel/automake-1.4
	>=sys-devel/bison-1.35
	sys-libs/zlib
	X? ( virtual/x11 )
	Xaw3d? ( x11-libs/Xaw3d )
	sdl? ( media-libs/sdl-mixer
			media-libs/sdl-image
			>=media-libs/libsdl-1.1.4 )
	gtk? ( =x11-libs/gtk+-1*
			>=dev-libs/glib-1.2.5
			>=media-libs/imlib-1.9.2
			>=media-libs/libogg-1.0
			>=media-libs/libvorbis-1.0-r2 )
	gtk2? ( >=x11-libs/gtk+-2.0.0
			>=dev-libs/glib-2.0.0
			>=dev-libs/atk-1.0.3
			>=x11-libs/pango-1.0.5
			>=media-libs/libogg-1.0
			>=media-libs/libvorbis-1.0-r2 )"

src_compile() {
	local myconf="--enable-client=no"

	use X \
		&& myconf="${myconf} --enable-client=xaw --with-x" \
		|| myconf="${myconf} --disable-client=xaw --without-x"

	use Xaw3d \
		&& myconf="${myconf} --enable-client=xaw3d --disable-gtktest"

	use gtk \
		&& myconf="${myconf} --enable-client=gtk --enable-gtktest" \
		|| myconf="${myconf} --disable-client=gtk --disable-gtktest"

	use gtk2 \
		&& myconf="${myconf} --enable-client=gtk-2.0 --enable-gtktest" \
		|| myconf="${myconf} --disable-client=gtk-2.0 --disable-gtktest"

	use sdl \
		&& myconf="${myconf} --enable-client=sdl" \
		|| myconf="${myconf} --disable-sdltest --disable-sdl-mixer"

	use nls \
		|| myconf="${myconf} --disable-nls"

	egamesconf --with-zlib ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	make prefix=${D}/usr datadir=${D}/${GAMES_DATADIR} install || die "make install failed"

	use gtk	|| use gtk2 || /bin/install -D -m 644 \
		${S}/data/Freeciv \
		${D}/usr/X11R6/lib/X11/app-defaults/Freeciv

	dodoc ChangeLog INSTALL NEWS \
		doc/{BUGS,CodingStyle,HACKING,HOWTOPLAY,PEOPLE,README*,TODO}
}
