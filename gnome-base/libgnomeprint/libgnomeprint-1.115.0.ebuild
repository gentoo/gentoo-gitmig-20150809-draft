# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprint/libgnomeprint-1.115.0.ebuild,v 1.2 2002/07/11 06:30:26 drobbins Exp $

inherit gnome2


S=${WORKDIR}/${P}
DESCRIPTION="Printer handling for Gnome"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"


RDEPEND=">=gnome-base/libbonobo-2.0.0
	>=media-libs/libart_lgpl-2.3.8
	>=x11-libs/pango-1.0.0
	>=dev-libs/libxml2-2.4.22
	>=dev-libs/glib-2.0.0
	>=media-libs/freetype-2.0.9"
		
DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.9-r2 )
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING*  ChangeLog* INSTALL NEWS README"

pkg_postinst() {
	echo ">>> Updating Fonts"
	libgnomeprint-2.0-font-install \
		--debug \
		--smart \
		--static \
		--aliases=/usr/share/gnome/libgnomeprint-2.0/fonts/adobe-urw.font \
		--target=/usr/share/gnome/libgnomeprint-2.0/fonts/gnome-print.fontmap
				
} 


