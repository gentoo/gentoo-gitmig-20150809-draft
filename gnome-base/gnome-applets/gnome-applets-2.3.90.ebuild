# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-applets/gnome-applets-2.3.90.ebuild,v 1.1 2003/09/07 23:31:39 foser Exp $

inherit gnome2

DESCRIPTION="Applets for the Gnome2 Desktop and Panel"
HOMEPAGE="http://www.gnome.org/"

IUSE="doc"
SLOT="2"
LICENSE="GPL-2 FDL-1.1" 
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64"

RDEPEND=">=x11-libs/gtk+-2.1
	>=gnome-base/gail-1.3
	>=gnome-base/gconf-1.2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgtop-2
	>=gnome-base/gnome-panel-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2"
											
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11
	doc? ( dev-util/gtk-doc )"

src_unpack() {

	unpack ${A}

	cd ${S}
	gnome2_omf_fix

}

# FIXME
#src_install() {
#	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
#	make prefix=${D}/usr \
#		sysconfdir=${D}/etc \
#		infodir=${D}/usr/share/info \
#		mandir=${D}/usr/share/man \
#		localstatedir=${D}/var \
#		install || die
#	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
    
#	dodoc AUTHORS ChangeLog COPYING* README* INSTALL NEWS message-of-doom 
#	docinto battstat
#	dodoc battstat/AUTHORS battstat/ChangeLog battstat/README battstat/TODO
#	docinto cdplayer
#	dodoc cdplayer/ChangeLog
#	docinto charpic
#	dodoc charpic/ChangeLog
#	docinto drivemount
#	dodoc drivemount/AUTHORS drivemount/ChangeLog
#	docinto geyes
#	dodoc geyes/AUTHORS geyes/ChangeLog geyes/NEWS geyes/README*
#	docinto gkb-new
#	dodoc gkb-new/AUTHORS gkb-new/ChangeLog gkb-new/README gkb-new/TODO
#	docinto gtik
#	dodoc gtik/AUTHORS gtik/README gtik/ChangeLog gtik/NEWS
#	docinto gweather
#	dodoc gweather/AUTHORS gweather/ChangeLog gweather/NEWS gweather/README gweather/TODO
#	docinto mini-commander
#	dodoc mini-commander/AUTHORS mini-commander/ChangeLog mini-commander/NEWS mini-commander/README mini-commander/TODO
#	docinto mixer
#	dodoc mixer/AUTHORS mixer/ChangeLog
#	docinto modemlights
#	dodoc modemlights/AUTHORS modemlights/ChangeLog modemlights/TODO
#	docinto multiload
#	dodoc multiload/AUTHORS multiload/ChangeLog
#}
