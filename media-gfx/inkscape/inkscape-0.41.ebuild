# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/inkscape/inkscape-0.41.ebuild,v 1.1 2005/03/22 18:00:42 sekretarz Exp $

inherit gnome2 eutils

DESCRIPTION="A SVG based generic vector-drawing program"
HOMEPAGE="http://www.inkscape.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="gnome mmx perl python bonobo inkjar doc plugin"

RDEPEND=">=x11-libs/gtk+-2.4.1
	>=media-libs/libart_lgpl-2.3.16
	>=dev-libs/libxml2-2.6.7
	>=x11-libs/pango-1.4.0
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
		  app-office/dia )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

G2CONF="${G2CONF} --with-xft"
use mmx || G2CONF="${G2CONF} --disable-mmx"
use bonobo || G2CONF="${G2CONF} --without-bonobo"
use inkjar || G2CONF="${G2CONF} --without-inkjar"
use gnome && G2CONF="${G2CONF} --with-gnome-print"
use perl && G2CONF="${G2CONF} --with-perl"
use python && G2CONF="${G2CONF} --with-python"

src_unpack() {
	unpack ${A}

	# fix for gnome-print error
	cd ${S}
	epatch ${FILESDIR}/${P}_gnome-print.patch
}

DOCS="AUTHORS COPYING ChangeLog HACKING NEWS README"

pkg_postinst() {
	einfo "Inkscape 0.41 adds several new optional extensions."
	einfo "It is normal to get a warning the first time Inkscape is run,"
	einfo ""
	einfo "If you want all extensions supported, recompile Inkscape"
	einfo "with the \'plugin\' USE flag. It will install:"
	einfo ""
	einfo "  >=media-gfx/pstoedit-3.33"
	einfo "  >=media-gfx/skencil-0.6.16"
	einfo "  media-libs/libwmf"
	einfo "  app-office/dia"
}
