# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-2.0.3.ebuild,v 1.3 2002/09/05 21:34:48 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="A filemanager for the Gnome2 desktop"
SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1 FDL-1.1"
KEYWORDS="x86 ppc sparc sparc64"

RDEPEND="app-admin/fam-oss
	>=dev-libs/glib-2.0.6-r1
	>=gnome-base/gconf-1.2.1
	>=x11-libs/gtk+-2.0.6-r1
	>=dev-libs/libxml2-2.4.23
	>=gnome-base/gnome-vfs-2.0.2
	>=media-sound/esound-0.2.28
	>=gnome-base/bonobo-activation-1.0.3
	>=gnome-base/eel-2.0.3
	>=gnome-base/gail-0.16
	>=gnome-base/libgnome-2.0.2
	>=gnome-base/libgnomeui-2.0.1
	>=gnome-base/gnome-desktop-2.0.5
	>=media-libs/libart_lgpl-2.3.10
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/libgnomecanvas-2.0.1
	>=gnome-base/librsvg-2.0.1
	>=app-text/scrollkeeper-0.3.6
	>=gnome-extra/gnome-utils-2.0.1"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"


G2CONF="${G2CONF} --enable-platform-gnome-2 --enable-gdialog=yes"
DOCS="AUTHORS COPYIN* ChangeLo* HACKING INSTALL MAINTAINERS NEWS README THANKS TODO"

src_compile () {
	# Also apply the "reverse deps" patch.
	#
	# http://bugzilla.gnome.org/show_bug.cgi?id=75635
	ELTCONF="${ELTCONF} --reverse-deps"
	gnome2_src_configure ${1}
	make || die "compile dislikes me"
}

