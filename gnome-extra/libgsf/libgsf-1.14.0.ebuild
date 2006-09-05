# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgsf/libgsf-1.14.0.ebuild,v 1.10 2006/09/05 20:50:38 tcort Exp $

inherit eutils gnome2

DESCRIPTION="The GNOME Structured File Library"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="bzip2 doc gnome static"

RDEPEND=">=dev-libs/libxml2-2.4.16
	>=dev-libs/glib-2.6
	sys-libs/zlib
	gnome? ( media-gfx/imagemagick
		media-libs/libwmf
		>=gnome-base/gconf-2
		>=gnome-base/libbonobo-2
		>=gnome-base/gnome-vfs-2.2 )
	bzip2? ( app-arch/bzip2 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	doc? ( >=dev-util/gtk-doc-1 )"

G2CONF="${G2CONF} \
	$(use_with bzip2 bz2) \
	$(use_with gnome) \
	$(use_enable static)"

src_install() {

	gnome2_src_install

	preserve_old_lib /usr/$(get_libdir)/libgsf-1.so.1
	preserve_old_lib /usr/$(get_libdir)/libgsf-gnome-1.so.1
	preserve_old_lib /usr/$(get_libdir)/libgsf-1.so.113
	preserve_old_lib /usr/$(get_libdir)/libgsf-gnome-1.so.113

}

pkg_postinst() {

	gnome2_pkg_postinst

	preserve_old_lib_notify /usr/$(get_libdir)/libgsf-1.so.1
	preserve_old_lib_notify /usr/$(get_libdir)/libgsf-gnome-1.so.1
	preserve_old_lib_notify /usr/$(get_libdir)/libgsf-1.so.113
	preserve_old_lib_notify /usr/$(get_libdir)/libgsf-gnome-1.so.113

}

DOCS="AUTHORS BUGS ChangeLog HACKING NEWS README TODO"
