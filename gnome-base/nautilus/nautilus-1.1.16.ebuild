# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider <spider@gentoo.org> 
# Maintainer:  Spider <spider@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-1.1.16.ebuild,v 1.1 2002/05/22 22:05:29 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="A filemanager for the Gnome2 desktop"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1 FDL-1.1"

RDEPEND=">=dev-libs/glib-2.0.1
	>=gnome-base/gconf-1.1.9
	>=x11-libs/gtk+-2.0.2
	>=dev-libs/libxml2-2.4.20
	>=gnome-base/gnome-vfs-1.9.12
	>=media-sound/esound-0.2.25
	>=gnome-base/bonobo-activation-0.9.7
	>=gnome-base/eel-1.1.14
	>=gnome-base/libgnome-1.115.0
	>=gnome-base/libgnomeui-1.115.0
	>=gnome-base/gnome-desktop-1.5.17
	>=media-libs/libart_lgpl-2.3.8-r1
	>=gnome-base/libbonobo-1.115.0
	>=gnome-base/libbonoboui-1.115.0
	>=gnome-base/libgnomecanvas-1.115.0
	>=gnome-base/librsvg-1.1.6
	>=app-text/scrollkeeper-0.3.6"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"
src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-platform-gnome-2 \
		--enable-debug=yes || die
	make || die
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
 	dodoc AUTHORS COPYIN* ChangeLo* HACKING INSTALL MAINTAINERS NEWS README THANKS TODO 
}


pkg_postinst() {
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	echo ">>> updating GConf2"
	for SCHEMA in nautilus.schemas apps_nautilus_preferences.schemas; do
		echo $SCHEMA
		/usr/bin/gconftool-2 --makefile-install-rule \
			/etc/gconf/schemas/${SCHEMA}
	done
	echo ">>> updating scrollkeeper"
	scrollkeeper-update -p /var/lib/scrollkeeper
}


