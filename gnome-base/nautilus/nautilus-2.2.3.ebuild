# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-2.2.3.ebuild,v 1.5 2003/05/25 08:57:18 liquidx Exp $

inherit gnome2 eutils

S=${WORKDIR}/${P}
DESCRIPTION="A filemanager for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/projects/nautilus/"
SLOT="0"
LICENSE="GPL-2 LGPL-2 FDL-1.1"
KEYWORDS="x86 ~ppc ~alpha ~sparc"
IUSE="oggvorbis"

RDEPEND="app-admin/fam-oss
	>=dev-libs/glib-2
	>=x11-libs/pango-1.1.2
	>=x11-libs/gtk+-2.1.1
	>=dev-libs/libxml2-2.4.7
	>=gnome-base/gnome-vfs-2.1.5
	>=media-sound/esound-0.2.27
	>=gnome-base/bonobo-activation-2.1
	>=gnome-base/eel-${PV}
	>=gnome-base/libgnome-2.1.1
	>=gnome-base/libgnomeui-2.1.1
	>=gnome-base/gnome-desktop-2.1
	>=media-libs/libart_lgpl-2.3.10
	>=gnome-base/libbonobo-2.1
	>=gnome-base/libbonoboui-2
	>=gnome-base/librsvg-2.0.1
	>=gnome-base/ORBit2-2.4
	sys-apps/eject
	x11-themes/gnome-icon-theme
	x11-themes/gnome-themes
	oggvorbis? ( media-sound/vorbis-tools )"

DEPEND="${RDEPEND} 
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.12.0
	>=gnome-base/gconf-1.2.1"

G2CONF="${G2CONF} --enable-gdialog=yes"

DOCS="AUTHORS COPYIN* ChangeLo* HACKING INSTALL MAINTAINERS NEWS README THANKS TODO"

# needed for 2.2.3 only
export SED=sed
