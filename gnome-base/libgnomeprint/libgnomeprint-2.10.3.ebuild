# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprint/libgnomeprint-2.10.3.ebuild,v 1.9 2005/08/23 01:40:04 agriffis Exp $

inherit gnome2

DESCRIPTION="Printer handling for Gnome"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2.2"
KEYWORDS="~alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="cups doc"

RDEPEND=">=dev-libs/glib-2
	sys-libs/zlib
	dev-libs/popt
	>=x11-libs/pango-1.6
	>=media-libs/fontconfig-1
	>=media-libs/libart_lgpl-2.3.7
	>=dev-libs/libxml2-2.4.23
	>=media-libs/freetype-2.0.5
	cups? ( >=net-print/cups-1.1.20
		>=net-print/libgnomecups-0.2 )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0
	doc? ( =app-text/docbook-sgml-dtd-3.0*
		>=dev-util/gtk-doc-0.9 )"

G2CONF="${G2CONF} `use_with cups`"

DOCS="AUTHORS ChangeLog* NEWS README"

USE_DESTDIR="1"
