# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnome/libgnome-1.117.0.ebuild,v 1.1 2002/05/22 22:03:44 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="Essential Gnome Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 LGPL-2.1"


RDEPEND=">=dev-libs/libxslt-1.0.16
	>=dev-libs/glib-2.0.0
	>=gnome-base/gconf-1.1.9
	>=gnome-base/gnome-mime-data-1.0.7
	>=gnome-base/libbonobo-1.116.0
	>=gnome-base/gnome-vfs-1.9.13
	>=media-sound/esound-0.2.25
	>=media-libs/audiofile-0.2.3
	>=dev-libs/libxml2-2.4.17
	>=sys-apps/gawk-3.1.0
	>=sys-devel/perl-5.6.1-r3"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.17
	doc? ( >=dev-util/gtk-doc-0.9 )
	>=dev-util/pkgconfig-0.12.0"
src_compile() {
	local myconf
	libtoolize --copy --force
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
	./configure --host=${CHOST} \
		    --prefix=/usr \
			--sysconfdir=/etc \
		    --infodir=/usr/share/info \
		    --mandir=/usr/share/man \
			${myconf} \
		    --enable-debug=yes || die "configure failure"

	emake || die "compile failure"
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	dodoc AUTHORS COPYING*  ChangeLog INSTALL NEWS README
}
pkg_postinst() {
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	for SCHEMA in desktop_gnome_accessibility_keyboard.schemas desktop_gnome_applications_browser.schemas  desktop_gnome_applications_editor.schemas desktop_gnome_applications_help_viewer.schemas  desktop_gnome_applications_terminal.schemas desktop_gnome_applications_window_manager.schemas desktop_gnome_background.schemas desktop_gnome_file_views.schemas desktop_gnome_interface.schemas desktop_gnome_peripherals_keyboard.schemas desktop_gnome_peripherals_mouse.schemas desktop_gnome_sound.schemas desktop_gnome_url_handlers.schemas ; do
		echo ${SCHEMA}
		/usr/bin/gconftool-2  --makefile-install-rule \
			/etc/gconf/schemas/${SCHEMA}
	done
}
	
