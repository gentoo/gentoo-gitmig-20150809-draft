# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/dopewars/dopewars-1.5.8.ebuild,v 1.1 2003/09/10 05:27:31 vapier Exp $

DESCRIPTION="Re-Write of the game Drug Wars"
SRC_URI="mirror://sourceforge/dopewars/${P}.tar.gz"
HOMEPAGE="http://dopewars.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE="nls ncurses gtk gtk2 gnome esd sdl"

DEPEND="=dev-libs/glib-1.2*
	ncurses? ( >=sys-libs/ncurses-5.2 )
	esd? ( media-sound/esound )
	gnome? ( gnome-base/gnome )
	gtk? ( =x11-libs/gtk+-1.2* )
	gtk2? ( =x11-libs/gtk+-2* )
	nls? ( sys-devel/gettext )
	sdl? ( media-libs/libsdl )"

src_compile() {
	# This patch fixes a problem when you try to compile dopewars without
	# a graphical or curses-based client, and the path to the doc dir.
	patch -p1 <${FILESDIR}/${P}-gentoo.diff

	local myconf=""

	use ncurses || myconf="--disable-curses-client"
	use nls     || myconf="$myconf --disable-nls"
	use sdl     || myconf="$myconf --without-sdl"
	use esd     || myconf="$myconf --without-esd"

	if [ "`use gtk`" ] || [ "`use gtk2`" ]
	then
		myconf="$myconf --enable-gui-server"
		use gtk2 || myconf="$myconf --disable-glib2"
	else
		myconf="$myconf --disable-gui-client"
	fi

	econf ${myconf} || die

	#emake fails sometimes in 1.5.7, dropping to make. (drobbins, 29 Aug 2002)
	make || die "Compilation failed"
}

src_install() {
	einstall

	use gnome || rm -rf ${D}/usr/share/gnome

	mv ${D}/usr/share/doc/${P} ${D}/usr/share/doc/${P}-orig
	dohtml -r ${D}/usr/share/doc/${P}-orig/*
	rm -rf ${D}/usr/share/doc/${P}-orig

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
