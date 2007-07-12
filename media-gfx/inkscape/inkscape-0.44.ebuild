# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/inkscape/inkscape-0.44.ebuild,v 1.9 2007/07/12 04:08:47 mr_bones_ Exp $

WANT_AUTOMAKE="1.9"
WANT_AUTOCONF="latest"

inherit gnome2 eutils autotools

DESCRIPTION="A SVG based generic vector-drawing program"
HOMEPAGE="http://www.inkscape.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 sparc ~x86"
IUSE="gnome mmx bonobo inkjar lcms boost doc plugin spell"

RDEPEND=">=x11-libs/gtk+-2.4.1
	>=dev-libs/glib-2.6.5
	>=media-libs/libart_lgpl-2.3.16
	>=dev-libs/libxml2-2.6.20
	>=x11-libs/pango-1.4.0
	>=dev-libs/libxslt-1.0.15
	dev-perl/XML-Parser
	dev-perl/XML-XQL
	dev-python/pyxml
	virtual/xft
	dev-libs/popt
	media-libs/fontconfig
	sys-libs/zlib
	media-libs/libpng
	>=sys-devel/gcc-3
	>=dev-libs/libsigc++-2.0.12
	>=dev-cpp/gtkmm-2.4
	dev-cpp/glibmm
	>=dev-libs/boehm-gc-6.4
	gnome? ( >=gnome-base/gnome-vfs-2.0 )
	lcms? ( >=media-libs/lcms-1.14 )
	boost? ( dev-libs/boost )
	plugin? ( >=media-gfx/pstoedit-3.33
			  >=media-gfx/skencil-0.6.16
		  media-libs/libwmf
		  app-office/dia )
	spell? ( app-text/gtkspell )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

G2CONF="${G2CONF} --with-xft"
G2CONF="${G2CONF} `use_with spell gtkspell`"
#G2CONF="${G2CONF} `use_with jabber inkboard`"
use mmx || G2CONF="${G2CONF} --disable-mmx"
use inkjar || G2CONF="${G2CONF} --without-inkjar"
use gnome && G2CONF="${G2CONF} --with-gnome-vfs"
use lcms || G2CONF="${G2CONF} --disable-lcms"

src_unpack() {
	unpack ${A}

	cd ${S}

	epatch ${FILESDIR}/inkscape-gcc42.diff

	eautoreconf
}

DOCS="AUTHORS COPYING ChangeLog HACKING NEWS README"
