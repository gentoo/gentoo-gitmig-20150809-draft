# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-applets/gnome-applets-2.0.0.ebuild,v 1.4 2002/08/16 04:09:22 murphy Exp $

inherit debug

S=${WORKDIR}/${P}
DESCRIPTION="Applets for the Gnome2 Desktop and Panel"
SRC_URI="mirror://gnome/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="GPL-2 FDL-1.1" 
KEYWORDS="x86 sparc sparc64"

RDEPEND=">=x11-libs/gtk+-2.0.0
	>=x11-libs/libwnck-0.6
	>=x11-libs/libzvt-1.112.0
	>=app-text/scrollkeeper-0.3.4
	>=sys-libs/ncurses-5.2-r3
	>=gnome-base/gail-0.13
	>=gnome-base/gconf-1.1.11
	>=gnome-base/gnome-vfs-1.9.16
	>=gnome-base/libgtop-2.0.0
	>=gnome-base/gnome-panel-2.0.0
	>=gnome-base/libglade-2.0.0"
											
DEPEND=">=dev-util/pkgconfig-0.12.0
	${DEPEND}"
		
src_compile() {
	libtoolize --copy --force
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--disable-install-schemas \
		--enable-platform-gnome-2 \
		--enable-debug=yes || die
	emake || die
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=$${D}/usr/share/man \
		install || die
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
    
	dodoc AUTHORS ChangeLog COPYING* README* INSTALL NEWS message-of-doom 
	docinto battstat
	dodoc battstat/AUTHORS battstat/ChangeLog battstat/README battstat/TODO
	docinto cdplayer
	dodoc cdplayer/ChangeLog
	docinto charpic
	dodoc charpic/ChangeLog
	docinto drivemount
	dodoc drivemount/AUTHORS drivemount/ChangeLog
	docinto geyes
	dodoc geyes/AUTHORS geyes/ChangeLog geyes/NEWS geyes/README*
	docinto gkb-new
	dodoc gkb-new/AUTHORS gkb-new/ChangeLog gkb-new/README gkb-new/TODO
	docinto gtik
	dodoc gtik/AUTHORS gtik/README gtik/ChangeLog gtik/NEWS
	docinto gweather
	dodoc gweather/AUTHORS gweather/ChangeLog gweather/NEWS gweather/README gweather/TODO
	docinto mini-commander
	dodoc mini-commander/AUTHORS mini-commander/ChangeLog mini-commander/NEWS mini-commander/README mini-commander/TODO
	docinto mixer
	dodoc mixer/AUTHORS mixer/ChangeLog
	docinto modemlights
	dodoc modemlights/AUTHORS modemlights/ChangeLog modemlights/TODO
	docinto multiload
	dodoc multiload/AUTHORS multiload/ChangeLog
}

pkg_postinst() {
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	echo ">>> updating GConf2 (modemlights)"
		for SCHEMA in \
		battstat.schemas    geyes.schemas     mini-commander.schemas \
		cdplayer.schemas    gkb.schemas       modemlights.schemas \
		charpick.schemas    gtik.schemas      multiload.schemas \
		drivemount.schemas  gweather.schemas  panel-menu.schemas ; do
 			echo $SCHEMA
			/usr/bin/gconftool-2  --makefile-install-rule \
				/etc/gconf/schemas/${SCHEMA}
		done
	echo ">>> updating scrollkeeper"
	scrollkeeper-update -p /var/lib/scrollkeeper
}
