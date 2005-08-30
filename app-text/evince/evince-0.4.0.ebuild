# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/evince/evince-0.4.0.ebuild,v 1.1 2005/08/30 19:40:24 dang Exp $

inherit gnome2 eutils

DESCRIPTION="Simple document viewer for GNOME"
HOMEPAGE="http://www.gnome.org/projects/evince/"
LICENSE="GPL-2"

IUSE="dbus doc dvi t1lib tiff"
# For use.local.desc:
# app-text/evince:t1lib - Enable Type1 fonts support in .dvi files

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="
	dvi? ( app-text/tetex )
	dvi? ( t1lib? ( >=media-libs/t1lib-5.0.0 ) )
	dbus? ( >=sys-apps/dbus-0.33 )
	tiff? ( media-libs/tiff )
	>=app-text/poppler-0.4.1
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-libs/glib-2
	>=gnome-base/gnome-vfs-2.0
	gnome-base/libgnome
	>=gnome-base/libgnomeprintui-2.6
	>=gnome-base/libgnomeui-2.6
	>=x11-libs/gtk+-2.8
	virtual/x11
	"


DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.30"

PROVIDE="virtual/pdfviewer
	virtual/psviewer"

G2CONF="${G2CONF} \
	$(use_enable dvi) \
	$(use_enable t1lib) \
	$(use_enable dbus) \
	$(use_enable tiff) \
	--disable-nautilus
	--disable-deprecated"

USE_DESTDIR="yes"
ELTCONF="--portage"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-t1lib_is_t1.patch
	automake || die "automake failed"
	gnome2_omf_fix ${S}/help/Makefile.in
	autoconf || die "autoconf failed"
	libtoolize --force || die "libtoolize failed"
}

src_install() {
	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/
}


DOCS="AUTHORS ChangeLog NEWS README"
