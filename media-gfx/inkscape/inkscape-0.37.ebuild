# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/inkscape/inkscape-0.37.ebuild,v 1.3 2004/02/19 10:14:00 zypher Exp $

inherit gnome2

DESCRIPTION="A SVG based generic vector-drawing program"
HOMEPAGE="http://www.inkscape.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~ppc"
IUSE="gnome mmx"

RDEPEND=">=x11-libs/gtk+-2.2.4
	>=media-libs/libart_lgpl-2.3.16
	>=dev-libs/libxml2-2.6.4
	virtual/xft
	media-libs/fontconfig
	dev-libs/popt
	sys-libs/zlib
	media-libs/libpng
	>=dev-libs/libsigc++-1.2
	gnome? ( >=gnome-base/libgnomeprint-2.2
		>=gnome-base/libgnomeprintui-2.2 )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

G2CONF="${G2CONF} --with-xft --with-popt"
use mmx || G2CONF="${G2CONF} --disable-mmx"
use gnome && G2CONF="${G2CONF} --with-gnome-print"

DOCS="AUTHORS COPYING ChangeLog HACKING NEWS README"
