# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-1.99.10.ebuild,v 1.1 2002/05/22 21:57:02 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="the gnome2 Desktop configuration tool"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="GPL-2"


RDEPEND=">=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0
	>=gnome-base/gconf-1.1.8
	>=gnome-base/libgnomeui-1.112.1
	>=gnome-base/libglade-1.99.8
	>=gnome-base/libbonobo-1.112.0
	>=gnome-base/libbonoboui-1.112.0
	>=gnome-base/gnome-vfs-1.9.10
	>=gnome-base/gnome-desktop-1.5.12
	>=app-text/scrollkeeper-0.3.4"
																		
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0" 

src_compile() {
	libtoolize --copy --force
	local myconf

	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var/lib \
		--enable-debug=yes || die

	emake || die
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var/lib \
		install || die
    unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	dodoc AUTHORS ChangeLog COPYING README* TODO INSTALL NEWS
}

pkg_postinst() {
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	echo ">>> Gconf2 update"
	for SCHEMA in apps_gnome_keybinding_properties.schemas apps_gnome_settings_daemon_screensaver.schemas ; do
		echo $SCHEMA
		/usr/bin/gconftool-2  --makefile-install-rule \
			/etc/gconf/schemas/${SCHEMA}
	done
	echo ">>> Scrollkeeper-update"
	scrollkeeper-update -p /var/lib/scrollkeeper
}

