# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprint/libgnomeprint-2.2.1.2.ebuild,v 1.4 2003/05/02 23:08:01 weeve Exp $

inherit gnome2

IUSE="cups doc"
DESCRIPTION="Printer handling for Gnome"
HOMEPAGE="http://www.gnome.org/"
SLOT="2.2"
KEYWORDS="x86 ~ppc alpha sparc"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/pango-1
	>=media-libs/fontconfig-1
	>=media-libs/libart_lgpl-2.3.7
	>=dev-libs/libxml2-2.4.23
	>=media-libs/freetype-2.0.5
	cups? ( >=net-print/cups-1.1 )"
		
DEPEND="${RDEPEND} 
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9 )"

use cups \
	&& G2CONF="${G2CONF} --with-cups" \
	|| G2CONF="${G2CONF} --without-cups"

DOCS="AUTHORS COPYING* ChangeLog* INSTALL NEWS README"
