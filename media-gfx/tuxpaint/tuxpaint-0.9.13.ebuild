# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/tuxpaint/tuxpaint-0.9.13.ebuild,v 1.1 2004/01/10 11:09:19 leonardop Exp $

DESCRIPTION="Drawing program designed for young children (kids ages 3 and up)"
HOMEPAGE="http://www.newbreedsoftware.com/tuxpaint/"

DEPEND="media-libs/libpng
	media-libs/sdl-ttf
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/libsdl
	>=media-libs/freetype-2
	media-libs/netpbm
	sys-devel/gettext"

IUSE="gnome kde"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	sed -i "s:^PREFIX=.*:PREFIX=/usr:" Makefile
	sed -i "s:^  CONFDIR=.*:  CONFDIR=/etc/tuxpaint:" Makefile
	sed -i "s/^CFLAGS=.*/CFLAGS=${CFLAGS}/" Makefile
	sed -i "s/^SDL_LIBS=/SDL_LIBS:=-lSDL_mixer /" Makefile
	sed -i "s/^SDL_CFLAGS=/SDL_CFLAGS:=/" Makefile

	if [ `use gnome` ]
	then
		sed -i "s:^GNOME_PREFIX=:GNOME_PREFIX=${D}:" Makefile
	else
		sed -i "s:^GNOME_PREFIX=.*:GNOME_PREFIX=:" Makefile
	fi

	if [ `use kde` ]
	then
		sed -i "s:^KDE_PREFIX=:KDE_PREFIX=${D}:" Makefile
		sed -i "s:^KDE_ICON_PREFIX=:KDE_ICON_PREFIX=${D}:" Makefile
	else
		sed -i "s:^KDE_PREFIX=.*:KDE_PREFIX=:" Makefile
		sed -i "s:^KDE_ICON_PREFIX=.*:KDE_ICON_PREFIX=:" Makefile
	fi

	# emake can cause some grief at this point..
	make || die
}

src_install () {
	sed -i "s:^PREFIX=.*:PREFIX=${D}usr:" Makefile
	sed -i "s:^  CONFDIR=.*:  CONFDIR=${D}etc/tuxpaint:" Makefile
	sed -i 's:make install-gnome.*:echo "   Nothing to install"; \\:' Makefile

	dodir /usr/bin
	use kde && dodir /usr/kde/3.1/share/applnk/Graphics \
		/usr/kde/3.1/share/icons/hicolor/48x48/apps \
		/usr/kde/3.1/share/icons/hicolor/32x32/apps \
		/usr/kde/3.1/share/icons/hicolor/16x16/apps

	make install || die

	rm docs/INSTALL.txt
	dodoc docs/*.txt
}
