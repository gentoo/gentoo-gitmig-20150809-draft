# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/inkscape/inkscape-0.40.ebuild,v 1.1 2004/12/07 23:31:53 chrb Exp $

inherit gnome2 eutils

DESCRIPTION="A SVG based generic vector-drawing program"
HOMEPAGE="http://www.inkscape.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE="gnome mmx doc"

RDEPEND=">=x11-libs/gtk+-2.4.1
	>=media-libs/libart_lgpl-2.3.16
	>=dev-libs/libxml2-2.6.7
	>=x11-libs/pango-1.4.0
	dev-perl/XML-Parser
	virtual/xft
	media-libs/fontconfig
	dev-libs/popt
	sys-libs/zlib
	media-libs/libpng
	=sys-devel/gcc-3*
	>=dev-libs/libsigc++-2.0.3
	>=dev-cpp/gtkmm-2.4
	gnome? ( >=gnome-base/libgnomeprint-2.2
		>=gnome-base/libgnomeprintui-2.2 )
	dev-libs/boehm-gc"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

G2CONF="${G2CONF} --with-xft --with-popt"
use mmx || G2CONF="${G2CONF} --disable-mmx"
use gnome && G2CONF="${G2CONF} --with-gnome-print"

src_unpack() {
	unpack ${A}
}

DOCS="AUTHORS COPYING ChangeLog HACKING NEWS README"
