# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/gwp/gwp-0.4.0.ebuild,v 1.2 2006/09/28 10:04:11 nyhm Exp $

inherit eutils games

DESCRIPTION="GNOME client for the classic PBEM strategy game VGA Planets 3"
HOMEPAGE="http://gwp.lunix.com.ar"
SRC_URI="http://gwp.lunix.com.ar/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="python opengl"

DEPEND="
	=x11-libs/gtk+-2*
	=gnome-base/libgnomeui-2*
	=gnome-base/libglade-2*
	app-text/scrollkeeper
	dev-libs/libpcre
	opengl? ( =dev-python/pygtk-2*
	    	  =x11-libs/gtkglext-1* )"
src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gcc41.patch"
}

src_compile() {
	egamesconf \
	   	$(use_enable opengl gtkglext) \
		$(use_enable python) \
		|| die "Error: econf failed!"
	emake || die "Error: emake failed!"
}

src_install () {
	make DESTDIR="${D}" localstatedir="${D}"/var/games/gwp install || die "Error: install failed"
	dodoc AUTHORS ChangeLog README TODO
	doicon ${PN}.png
	make_desktop_entry gwp "Gnome WarPad"
	prepgamesdirs
}
