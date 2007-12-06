# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/inkscape/inkscape-0.45.1-r1.ebuild,v 1.1 2007/12/06 22:45:27 maekke Exp $

inherit gnome2

DESCRIPTION="A SVG based generic vector-drawing program"
HOMEPAGE="http://www.inkscape.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="dia doc gnome inkjar jabber lcms mmx perl postscript spell wmf"
RESTRICT="test"

COMMON_DEPEND=">=x11-libs/gtk+-2.10.7
	dev-cpp/glibmm
	>=dev-cpp/gtkmm-2.4
	>=dev-libs/boehm-gc-6.4
	>=dev-libs/glib-2.6.5
	>=dev-libs/libsigc++-2.0.12
	>=dev-libs/libxslt-1.0.15
	dev-libs/popt
	media-libs/fontconfig
	>=media-libs/freetype-2
	media-libs/libpng
	>=x11-libs/pango-1.4.0
	>=dev-libs/libxml2-2.6.20
	dev-python/pyxml
	virtual/xft
	gnome? (
		>=gnome-base/gnome-vfs-2.0
		gnome-base/libgnomeprint
		gnome-base/libgnomeprintui
	)
	jabber? ( >=net-libs/loudmouth-1.0 )
	lcms? ( >=media-libs/lcms-1.14 )
	perl? (
		dev-perl/XML-Parser
		dev-perl/XML-XQL
	)
	spell? ( app-text/gtkspell )"

# These only use executables provided by these packages
# See share/extensions for more details. inkscape can tell you to
# install these so we could of course just not depend on those and rely
# on that.
RDEPEND="
	${COMMON_DEPEND}
	dia? ( app-office/dia )
	postscript? ( >=media-gfx/pstoedit-3.44 media-gfx/skencil )
	wmf? ( media-libs/libwmf )"

DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	x11-libs/libX11
	>=dev-util/intltool-0.29"

pkg_setup() {
	G2CONF="${G2CONF} --with-xft"
	G2CONF="${G2CONF} $(use_with spell gtkspell)"
	G2CONF="${G2CONF} $(use_enable jabber inkboard)"
	G2CONF="${G2CONF} $(use_enable mmx)"
	G2CONF="${G2CONF} $(use_with inkjar)"
	G2CONF="${G2CONF} $(use_with gnome gnome-vfs)"
	G2CONF="${G2CONF} $(use_with gnome gnome-print)"
	G2CONF="${G2CONF} $(use_enable lcms)"
	G2CONF="${G2CONF} $(use_with perl)"
}

DOCS="AUTHORS COPYING ChangeLog NEWS README"
