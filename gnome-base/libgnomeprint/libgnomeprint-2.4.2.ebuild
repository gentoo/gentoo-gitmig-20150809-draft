# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprint/libgnomeprint-2.4.2.ebuild,v 1.5 2004/01/16 20:54:07 darkspecter Exp $

inherit gnome2

DESCRIPTION="Printer handling for Gnome"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2.2"
KEYWORDS="x86 ppc ~alpha sparc hppa amd64 ~ia64"
IUSE="cups doc"

RDEPEND=">=dev-libs/glib-2
	sys-libs/zlib
	dev-libs/popt
	>=x11-libs/pango-1
	>=media-libs/fontconfig-1
	>=media-libs/libart_lgpl-2.3.7
	>=dev-libs/libxml2-2.4.23
	>=media-libs/freetype-2.0.5
	cups? ( >=net-print/cups-1.1 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9 )"

G2CONF="${G2CONF} `use_with cups`"

DOCS="AUTHORS COPYING* ChangeLog* INSTALL NEWS README"
