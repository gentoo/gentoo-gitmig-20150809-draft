# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-2.1.2.ebuild,v 1.2 2002/11/28 01:42:43 foser Exp $

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="A filemanager for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1 FDL-1.1"
KEYWORDS="x86"
IUSE="oggvorbis"

RDEPEND="app-admin/fam-oss
	>=dev-libs/glib-2.0.6-r1
	>=gnome-base/gconf-1.2.1
	=x11-libs/gtk+-2.1*
	>=dev-libs/libxml2-2.4.24
	>=gnome-base/gnome-vfs-2.0.4
	>=media-sound/esound-0.2.29
	=gnome-base/bonobo-activation-2.1*
	=gnome-base/eel-2.1.2
	=gnome-base/gail-1.1*
	=gnome-base/libgnome-2.1*
	=gnome-base/libgnomeui-2.1*
	=gnome-base/gnome-desktop-2.1*
	>=media-libs/libart_lgpl-2.3.10
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/libbonoboui-2.0
	=gnome-base/libgnomecanvas-2.1*
	=gnome-base/librsvg-2.1*
	>=app-text/scrollkeeper-0.3.11
	=gnome-extra/gnome-utils-2.1*
	sys-apps/eject
	oggvorbis? ( media-sound/vorbis-tools )"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"


G2CONF="${G2CONF} --enable-platform-gnome-2 --enable-gdialog=yes"
DOCS="AUTHORS COPYIN* ChangeLo* HACKING INSTALL MAINTAINERS NEWS README THANKS TODO"
