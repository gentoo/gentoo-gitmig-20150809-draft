# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/alleyoop/alleyoop-0.8.2.ebuild,v 1.1 2004/05/13 00:12:29 dragonheart Exp $

inherit gnome2

DESCRIPTION="A Gtk+ front-end to the Valgrind memory checker for x86 GNU/ Linux."
HOMEPAGE="http://alleyoop.sourceforge.net/"
SRC_URI="mirror://sourceforge/alleyoop/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -sparc -ppc -alpha"
IUSE=""

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	>=gnome-base/gconf-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2.2
	sys-devel/binutils
	dev-util/valgrind
	dev-libs/atk
	dev-libs/expat
	dev-libs/libxml2
	dev-libs/openssl
	dev-libs/popt
	gnome-base/ORBit2
	gnome-base/gnome-vfs
	gnome-base/libbonobo
	gnome-base/libbonoboui
	gnome-base/libgnome
	gnome-base/libgnomecanvas
	media-libs/alsa-lib
	media-libs/audiofile
	media-libs/fontconfig
	media-libs/freetype
	media-libs/jpeg
	media-libs/libart_lgpl
	media-sound/esound
	virtual/glibc
	sys-libs/zlib
	virtual/x11
	x11-libs/pango"

#ldd ./usr/bin/alleyoop | cut -f 3 -d ' '  | xargs -n1 qpkg -f | sort -u
# for runtime dependancies

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
