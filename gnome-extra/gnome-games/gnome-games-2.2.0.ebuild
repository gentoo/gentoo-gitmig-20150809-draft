# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-2.2.0.ebuild,v 1.7 2003/06/29 22:25:28 darkspecter Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Games for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc alpha ~sparc"
LICENSE="GPL-2"

RDEPEND=">=app-text/scrollkeeper-0.3.11
	>=sys-libs/ncurses-5.2
	>=sys-devel/gettext-0.10.40
	>=gnome-base/gconf-1.2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22
	${RDEPEND}"

G2CONF="${G2CONF} --with-ncurses" 
		
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
