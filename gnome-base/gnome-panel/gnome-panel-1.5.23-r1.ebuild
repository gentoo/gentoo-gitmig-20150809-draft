# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="The Panel for Gnome2"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 FDL-1.1 LGPL-2.1"

RDEPEND=">=x11-libs/gtk+-2.0.0
	>=dev-util/intltool-0.17
	>=dev-libs/libxml2-2.4.22
	>=dev-libs/atk-1.0.0
	>=dev-libs/glib-2.0.0
	>=gnome-base/ORBit2-2.4.0
	>=gnome-base/bonobo-activation-0.9.9
	>=gnome-base/gconf-1.1.10
	>=gnome-base/gnome-vfs-1.9.11
	>=media-libs/libart_lgpl-2.3.8
	>=gnome-base/libbonobo-1.117.0
	>=gnome-base/libbonoboui-1.117.0
	>=gnome-base/libglade-1.99.10
	>=gnome-base/libgnome-1.117.0
	>=gnome-base/libgnomecanvas-1.117.0
	>=gnome-base/libgnomeui-1.117.0
	>=x11-libs/libwnck-0.7
	>=net-libs/linc-0.5.0
	>=media-libs/audiofile-0.2.3
	>=sys-libs/zlib-1.1.4
	>=gnome-base/gnome-desktop-1.5.21
	>=app-text/scrollkeeper-0.3.4"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"

LIBTOOL_HACK="1"

DOC="AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS  README*"
SCHEMA="clock.schemas panel-global-config.schemas panel-per-panel-config.schemas mailcheck.schemas pager.schemas tasklist.schemas fish.schemas"


