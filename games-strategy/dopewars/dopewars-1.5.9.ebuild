# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/dopewars/dopewars-1.5.9.ebuild,v 1.1 2003/09/10 05:27:31 vapier Exp $

inherit games eutils

DESCRIPTION="Re-Write of the game Drug Wars"
SRC_URI="mirror://sourceforge/dopewars/${P}.tar.gz"
HOMEPAGE="http://dopewars.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="nls ncurses gtk gtk2 gnome esd sdl"

DEPEND="=dev-libs/glib-1.2*
	ncurses? ( >=sys-libs/ncurses-5.2 )
	esd? ( media-sound/esound )
	gnome? ( gnome-base/gnome )
	gtk? ( =x11-libs/gtk+-1.2* )
	gtk2? ( =x11-libs/gtk+-2* )
	nls? ( sys-devel/gettext )
	sdl? ( media-libs/libsdl media-libs/sdl-mixer )"

src_compile() {
	local myservconf=""
	if [ `use gtk` ] || [ `use gtk2` ] ; then
		myservconf="--enable-gui-server `use_enable gtk2 glib2`"
	else
		myservconf="--disable-gui-client"
	fi

	egamesconf \
		`use_enable ncurses curses-client` \
		`use_enable nls` \
		`use_with sdl` \
		`use_with esd` \
		--enable-networking \
		--enable-plugins \
		${myservconf} \
		|| die
	emake || die "Compilation failed"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README TODO

	cd ${D}/${GAMES_DATADIR}
	use gnome \
		&& mv gnome ../ \
		|| rm -rf gnome
	mv pixmaps ../
	dohtml -r doc/*/*
	rm -rf doc
	rm dopewars.sco

	prepgamesdirs
}
