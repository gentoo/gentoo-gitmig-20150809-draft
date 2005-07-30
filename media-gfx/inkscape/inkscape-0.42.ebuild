# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/inkscape/inkscape-0.42.ebuild,v 1.1 2005/07/30 10:03:27 sekretarz Exp $

inherit gnome2 eutils

DESCRIPTION="A SVG based generic vector-drawing program"
HOMEPAGE="http://www.inkscape.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="gnome mmx perl python bonobo inkjar doc plugin effects spell"

RDEPEND=">=x11-libs/gtk+-2.4.1
	>=media-libs/libart_lgpl-2.3.16
	>=dev-libs/libxml2-2.6.7
	>=x11-libs/pango-1.4.0
	>=dev-libs/libxslt-1.0.15
	dev-perl/XML-Parser
	virtual/xft
	dev-libs/popt
	media-libs/fontconfig
	sys-libs/zlib
	media-libs/libpng
	=sys-devel/gcc-3*
	>=dev-libs/libsigc++-2.0.3
	>=dev-cpp/gtkmm-2.4
	dev-cpp/glibmm
	gnome? ( >=gnome-base/libgnomeprint-2.2
		>=gnome-base/libgnomeprintui-2.2 )
	>=dev-libs/boehm-gc-6.4
	perl? ( dev-lang/perl )
	python? ( dev-lang/python )
	plugin? ( >=media-gfx/pstoedit-3.33
	          >=media-gfx/skencil-0.6.16
		  media-libs/libwmf
		  app-office/dia )
	effects? ( dev-python/pyxml
		     dev-perl/XML-XQL )
	spell? ( app-text/gtkspell )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

G2CONF="${G2CONF} --with-xft"
G2CONF="${G2CONF} `use_with spell gtkspell`"
use mmx || G2CONF="${G2CONF} --disable-mmx"
use bonobo || G2CONF="${G2CONF} --without-bonobo"
use inkjar || G2CONF="${G2CONF} --without-inkjar"
use gnome && G2CONF="${G2CONF} --with-gnome-print"
use perl && G2CONF="${G2CONF} --with-perl"
use python && G2CONF="${G2CONF} --with-python"

src_unpack() {
	unpack ${A}

	cd ${S}
	autoconf || die
	libtoolize --copy --force || die
}

DOCS="AUTHORS COPYING ChangeLog HACKING NEWS README"
