# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-applets/gnome-applets-2.1.1.ebuild,v 1.1 2002/11/13 00:25:15 foser Exp $

IUSE="doc"

inherit libtool gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="Applets for the Gnome2 Desktop and Panel"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="GPL-2 FDL-1.1" 
KEYWORDS="x86 ppc sparc sparc64 alpha"

RDEPEND=">=x11-libs/gtk+-2.0.6
	>=x11-libs/libwnck-0.17
	>=x11-libs/libzvt-2.0.1
	>=app-text/scrollkeeper-0.3.11
	>=sys-libs/ncurses-5.2-r3
	=gnome-base/gail-1.1*
	>=gnome-base/gconf-1.2.1
	=gnome-base/gnome-vfs-2.1*
	>=gnome-base/libgtop-2.0.0
	=gnome-base/gnome-panel-2.1*
	>=gnome-base/libglade-2.0.1"
											
DEPEND=">=dev-util/pkgconfig-0.12.0
	doc? ( dev-util/gtk-doc )
	${DEPEND}"

src_unpack() {
	unpack ${A}
	
	# fix wrong path
	cd ${S}/multiload
	cp GNOME_MultiLoadApplet_Factory.server.in GNOME_MultiLoadApplet_Factory.server.in.old
	sed -e "s:/home/hadess/garnome//libexec:/usr/libexec:" GNOME_MultiLoadApplet_Factory.server.in.old > GNOME_MultiLoadApplet_Factory.server.in
}
		
src_compile() {
	elibtoolize
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--disable-install-schemas \
		--enable-platform-gnome-2 \
		--enable-panelmenu=yes || die
	make || die
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var \
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
	gnome2_gconf_install
	scrollkeeper-update -p /var/lib/scrollkeeper
}
