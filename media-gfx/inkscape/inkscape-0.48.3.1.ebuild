# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/inkscape/inkscape-0.48.3.1.ebuild,v 1.3 2012/05/05 07:00:26 jdhore Exp $

EAPI=4

PYTHON_DEPEND="*"
PYTHON_USE_WITH="xml"

inherit autotools eutils flag-o-matic gnome2 python

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

DESCRIPTION="A SVG based generic vector-drawing program"
HOMEPAGE="http://www.inkscape.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE="dia gnome gs inkjar lcms nls spell wmf"

RESTRICT="test"

COMMON_DEPEND="
	>=app-text/poppler-0.12.3-r3[cairo,xpdf-headers]
	dev-cpp/glibmm
	>=dev-cpp/gtkmm-2.18.0:2.4
	>=dev-libs/boehm-gc-6.4
	>=dev-libs/glib-2.6.5
	>=dev-libs/libsigc++-2.0.12
	>=dev-libs/libxml2-2.6.20
	>=dev-libs/libxslt-1.0.15
	dev-libs/popt
	dev-python/lxml
	media-gfx/imagemagick[cxx]
	media-libs/fontconfig
	media-libs/freetype:2
	>=media-libs/libpng-1.2
	app-text/libwpd:0.9
	app-text/libwpg:0.2
	sci-libs/gsl
	x11-libs/libX11
	>=x11-libs/gtk+-2.10.7:2
	>=x11-libs/pango-1.4.0
	gnome? ( >=gnome-base/gnome-vfs-2.0 )
	lcms? ( media-libs/lcms:2 )
	spell? (
		app-text/aspell
		app-text/gtkspell:2
	)"

# These only use executables provided by these packages
# See share/extensions for more details. inkscape can tell you to
# install these so we could of course just not depend on those and rely
# on that.
RDEPEND="
	${COMMON_DEPEND}
	dev-python/numpy
	media-gfx/uniconvertor
	dia? ( app-office/dia )
	gs? ( app-text/ghostscript-gpl )
	wmf? ( media-libs/libwmf )"

DEPEND="${COMMON_DEPEND}
	dev-libs/boost
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.29"

pkg_setup() {
	G2CONF="${G2CONF} --without-perl"
	G2CONF="${G2CONF} --enable-poppler-cairo"
	G2CONF="${G2CONF} $(use_with gnome gnome-vfs)"
	G2CONF="${G2CONF} $(use_with inkjar)"
	G2CONF="${G2CONF} $(use_enable lcms)"
	G2CONF="${G2CONF} $(use_enable nls)"
	G2CONF="${G2CONF} $(use_with spell aspell)"
	G2CONF="${G2CONF} $(use_with spell gtkspell)"
	DOCS="AUTHORS ChangeLog NEWS README*"
}

src_prepare() {
	gnome2_src_prepare
	epatch "${FILESDIR}"/${PN}-0.48.0-spell.patch \
		"${FILESDIR}"/${PN}-0.48.1-libpng15.patch \
		"${FILESDIR}"/${PN}-0.48.2-libwpg.patch
	eautoreconf
}

src_configure() {
	# aliasing unsafe wrt #310393
	append-flags -fno-strict-aliasing
	gnome2_src_configure
}
