# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-1.99.10-r1.ebuild,v 1.1 2002/06/04 08:49:11 blocke Exp $

inherit gnome2

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

DOCS="AUTHORS ChangeLog COPYING README* TODO INSTALL NEWS"
SCHEMAS="apps_gnome_settings_daemon_screensaver.schemas"

