# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gtetrinet/gtetrinet-0.7.3-r1.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

# games after gnome2 so games' functions will override gnome2's
inherit gnome2 games

DESCRIPTION="Tetrinet Clone for GNOME 2"
HOMEPAGE="http://gtetrinet.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="nls ipv6"

RDEPEND="dev-libs/libxml2
	>=media-sound/esound-0.2.5
	>=gnome-base/gconf-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_compile() {
	sed -i "s:\$(datadir)/pixmaps:/usr/share/pixmaps:" {.,icons,src}/Makefile.in
	egamesconf `use_enable ipv6` || die
	emake || die "Compilation failed"
}

src_install() {
	USE_DESTDIR=1
	gnome2_src_install
	dodoc AUTHORS ChangeLog NEWS README TODO

	# move some stuff around
	cd ${D}/${GAMES_PREFIX}
	mkdir bin && mv games/gtetrinet bin/
	rm -rf games
	cd ${D}/${GAMES_DATADIR}
	mv applications locale ../
	use nls || rm -rf ../locale

	prepgamesdirs
}

pkg_postinst() {
	SCROLLKEEPER_UPDATE=0
	gnome2_pkg_postinst
	games_pkg_postinst
}
