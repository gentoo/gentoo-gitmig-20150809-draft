# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/inkscape/inkscape-0.37.ebuild,v 1.1 2004/02/18 15:43:59 zypher Exp $

inherit gnome2

DESCRIPTION="A vector drawing program for GNOME initially based on sodipodi"
HOMEPAGE="http://www.inkscape.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="gnome mmx"

RDEPEND=">=x11-libs/gtk+-2.2.4
	>=media-libs/libart_lgpl-2.3.16
	>=dev-libs/atk-1.4.1
	>=dev-libs/libxml2-2.6.4
	virtual/xft
	media-libs/fontconfig
	dev-libs/popt
	sys-libs/zlib
	media-libs/libpng
	>=x11-libs/pango-1.2.5
	>=dev-libs/libsigc++-1.2.5
	gnome? ( >=gnome-base/librsvg-2.4.0
	        >=gnome-base/libgnomeprint-2.2
		>=gnome-base/libgnomeprintui-2.2 )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.22"

G2CONF="${G2CONF} `use_enable mmx` `use_with gnome`"
G2CONF="${G2CONF} --with-xft --with-popt"
# disable experimental features for now
G2CONF="${G2CONF} --without-mlview --without-kde"

DOCS="AUTHORS COPYING ChangeLog HACKING NEWS README TODO"
