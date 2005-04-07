# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/librsvg/librsvg-2.8.1-r1.ebuild,v 1.7 2005/04/07 15:23:18 blubb Exp $

inherit gnome2

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="http://librsvg.sourceforge.net/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc64 sparc x86"
IUSE="doc zlib gnome"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=media-libs/libart_lgpl-2.3.10
	>=dev-libs/libxml2-2.4.7
	>=x11-libs/pango-1.2
	>=dev-libs/popt-1.5
	>=dev-libs/libcroco-0.6
	zlib? ( >=gnome-extra/libgsf-1.6 )
	gnome? ( >=gnome-base/gnome-vfs-2 )"

# FIXME : silent deps on libgnomeprint

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12
	doc? ( >=dev-util/gtk-doc-0.9 )"

# FIXME : USEify croco support (?)
G2CONF="${G2CONF} \
	$(use_with zlib svgz) \
	$(use_enable gnome gnome_vfs) \
	--with-croco \
	--enable-pixbuf-loader \
	--enable-gtk-theme"

DOCS="AUTHORS ChangeLog README NEWS TODO"

src_unpack() {

	unpack ${A}
	cd ${S}
	# Fix the location of HTML_DIR for gtk-doc/devhelp
	# see bug #77419, has been sent upstream so,
	# only patching configure for this version
	sed -i -e "s/doc\/librsvg\/html/gtk-doc\/html\/rsvg/" configure

}

src_install() {

	gnome2_src_install

	# remove gdk-pixbuf loaders (#47766)
	rm -fr ${D}/etc

}

pkg_postinst() {

	gdk-pixbuf-query-loaders > /etc/gtk-2.0/gdk-pixbuf.loaders

}

pkg_postrm() {

	gdk-pixbuf-query-loaders > /etc/gtk-2.0/gdk-pixbuf.loaders

}
