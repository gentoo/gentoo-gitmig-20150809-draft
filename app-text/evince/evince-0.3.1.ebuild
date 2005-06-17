# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/evince/evince-0.3.1.ebuild,v 1.2 2005/06/17 23:21:45 dang Exp $

inherit gnome2 eutils

DESCRIPTION="Simple document viewer for GNOME"
HOMEPAGE="http://www.gnome.org/projects/evince/"
LICENSE="GPL-2"

IUSE="djvu doc dvi t1lib"
# For use.local.desc:
# app-text/evince:djvu - Enable DjVu files support
# app-text/evince:t1lib - Enable Type1 fonts support in .dvi files

SLOT="0"
KEYWORDS="~x86"

RDEPEND="
	djvu? ( app-text/djvu )
	>=app-text/poppler-0.3.2
	>=dev-libs/atk-1.9
	>=dev-libs/expat-1.95
	>=dev-libs/glib-2
	dev-libs/libxml2
	dev-libs/openssl
	dev-libs/popt
	>=gnome-base/gconf-2.0
	>=gnome-base/gnome-keyring-0.4
	>=gnome-base/gnome-vfs-2.0
	gnome-base/libbonobo
	gnome-base/libbonoboui
	>=gnome-base/libglade-2.0
	gnome-base/libgnome
	gnome-base/libgnomecanvas
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libgnomeui-2.4
	>=gnome-base/orbit-2
	media-libs/audiofile
	media-libs/fontconfig
	>=media-libs/freetype-2
	media-libs/jpeg
	media-libs/libart_lgpl
	dvi? ( t1lib? ( >=media-libs/t1lib-5.0.0 ) )
	media-sound/esound
	net-misc/howl
	virtual/x11
	>=x11-libs/gtk+-2.6.1
	x11-libs/pango
	dvi? ( app-text/tetex )
	"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.30"

PROVIDE="virtual/pdfviewer
	virtual/psviewer"

G2CONF="${G2CONF} \
	$(use_enable djvu) \
	$(use_enable dvi) \
	$(use_enable t1lib) \
	--disable-deprecated"

USE_DESTDIR="yes"
ELTCONF="--portage"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-t1lib_is_t1.patch
	autoconf || die "autoconf failed"
	automake || die "automake failed"
	libtoolize --force || die "libtoolize failed"
}

src_install() {
	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/
}


DOCS="AUTHORS ChangeLog NEWS README"
