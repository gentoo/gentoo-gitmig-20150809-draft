# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-2.0.7.ebuild,v 1.8 2003/05/25 08:57:18 liquidx Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="A filemanager for the Gnome2 desktop"
SRC_URI="mirror://gnome/2.0.2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/projects/nautilus/"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1 FDL-1.1"
KEYWORDS="x86 ppc sparc alpha"
IUSE="oggvorbis"

RDEPEND="app-admin/fam-oss
	>=dev-libs/glib-2.0.6-r1
	>=gnome-base/gconf-1.2.1
	>=x11-libs/gtk+-2.0.6-r1
	>=dev-libs/libxml2-2.4.24
	>=gnome-base/gnome-vfs-2.0.4
	>=media-sound/esound-0.2.29
	>=gnome-base/bonobo-activation-1.0.3
	>=gnome-base/eel-2.0.7
	>=gnome-base/gail-0.17
	>=gnome-base/libgnome-2.0.5
	>=gnome-base/libgnomeui-2.0.5
	>=gnome-base/gnome-desktop-2.0.8
	>=media-libs/libart_lgpl-2.3.10
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/libbonoboui-2.0.3
	>=gnome-base/libgnomecanvas-2.0.4
	>=gnome-base/librsvg-2.0.1
	>=app-text/scrollkeeper-0.3.11
	>=gnome-extra/gnome-utils-2.0.5
	sys-apps/eject
	oggvorbis? ( media-sound/vorbis-tools )"

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

