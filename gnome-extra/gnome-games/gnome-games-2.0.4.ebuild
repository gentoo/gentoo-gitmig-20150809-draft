# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-2.0.4.ebuild,v 1.3 2002/09/21 12:09:35 bjb Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Games for the Gnome2 desktop"
SRC_URI="mirror://gnome/2.0.1/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 sparc sparc64 ppc alpha"
LICENSE="GPL-2"

RDEPEND=">=dev-libs/glib-2.0.6
	>=x11-libs/pango-1.0.4
	>=dev-libs/atk-1.0.3
	>=x11-libs/gtk+-2.0.6
	>=x11-libs/libzvt-2.0.1
	>=media-libs/freetype-2.0.8
	>=dev-libs/libxml2-2.4.24
	>=app-text/scrollkeeper-0.3.11
	>=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1
	>=sys-devel/gettext-0.10.40
	>=gnome-base/libglade-2.0.1
	>=gnome-base/gconf-1.2.1
	>=gnome-base/gnome-vfs-2.0.4
	>=gnome-base/ORBit2-2.4.1
	>=gnome-base/bonobo-activation-1.0.3
	>=gnome-base/gnome-panel-2.0.8
	>=gnome-base/libgnome-2.0.4
	>=gnome-base/libgnomecanvas-2.0.4
	>=gnome-base/libgnomeui-2.0.5"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22
	${RDEPEND}"


G2CONF="${G2CONF} --with-ncurses --enable-debug=yes" 
		
src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
		einstall || die "install failure"
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL

	dodoc AUTHORS COPYING COPYING-DOCS ChangeLog HACKING INSTALL MAINTAINERS NEWS README TODO

	docinto aisleriot
	cd aisleriot
	dodoc AUTHORS ChangeLog TODO
	
	cd ../freecell
	docinto freecell
	dodoc AUTHORS ChangeLog NEWS README TODO

	cd ../gataxx
	docinto gataxx
	dodoc AUTHORS ChangeLog TODO
	
	cd ../glines
	docinto glines
	dodoc AUTHORS ChangeLog NEWS README TODO

	cd ../gnect
	docinto gnect
	dodoc AUTHORS ChangeLog TODO

	cd ../gnibbles
	docinto gnibbles
	dodoc  AUTHORS ChangeLog

	cd ../gnobots2
	docinto gnobots2
	dodoc  AUTHORS README
	
	cd ../gnome-stones
	docinto gnome-stones
	dodoc  ChangeLog README TODO
	
	cd ../gnometris
	docinto gnometris
	dodoc AUTHORS COPYING  ChangeLog TODO

	cd ../gnomine
	docinto gnomine 	
	dodoc AUTHORS ChangeLog README
	
	cd ../gnotravex
	docinto gnotravex
	dodoc AUTHORS  ChangeLog README

	cd ../gnotski
	docinto gnotski
	dodoc AUTHORS ChangeLog README

	cd ../gtali
	docinto gtali
	dodoc AUTHORS ChangeLog INSTALL README TODO

	cd ../iagno
	docinto iagno
	dodoc  AUTHORS ChangeLog

	cd ../mahjongg
	docinto mahjongg
	dodoc ChangeLog NEWS README TODO

	cd ../same-gnome
	docinto same-gnome
	dodoc ChangeLog README TODO

	cd ../xbill
	docinto xbill
	dodoc AUTHORS COPYING ChangeLog NEWS README README.Ports

	cd ..
	export SCROLLKEEPER_UPDATE="1"
}

