# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/passepartout/passepartout-0.7.0.ebuild,v 1.1 2008/12/20 01:18:48 loki_val Exp $

EAPI=2

inherit base eutils gnome2 libtool  autotools

DESCRIPTION="A DTP application for the X Window System"
HOMEPAGE="http://www.stacken.kth.se/project/pptout/"

IUSE="gnome"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

COMMON_DEPS="dev-cpp/libxmlpp:2.6
	>=dev-libs/libxml2-2
	dev-cpp/gtkmm:2.4
	dev-cpp/libgnomecanvasmm:2.6
	dev-libs/glib:2
	dev-libs/libsigc++:2
	media-libs/freetype:2
	virtual/fam
	gnome? (
			gnome-base/libgnome
			gnome-base/gnome-vfs
	)
	"

RDEPEND="${COMMON_DEPS}
	dev-libs/libxslt
	virtual/ghostscript"

DEPEND="${COMMON_DEPS}
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS BUGS NEWS README"

# GCC-4.2 patch:
# http://bugzilla.gnome.org/477017
# GCC-4.3 patch:
# Snatched from Debian
# http://bugzilla.gnome.org/565131
# include-flags:
# http://bugzilla.gnome.org/464517
# libtoolization:
# http://bugzilla.gnome.org/464567
# libxml-2.6:
# http://bugzilla.gnome.org/449596

# The include and libtoolization patches are needed for
# forced as-needed to work.

PATCHES=(
		"${FILESDIR}/${P}-gcc42.patch"
		"${FILESDIR}/${P}-gcc43.patch"
		"${FILESDIR}/${P}-gcc44.patch"
		"${FILESDIR}/${P}-include-flags.patch"
		"${FILESDIR}/${P}-libtoolization.patch"
		"${FILESDIR}/${P}-safer.patch"
		"${FILESDIR}/${P}-libxmlpp-2.6-depend.patch"
	)

pkg_setup() {
	G2CONF="$(use_with gnome)"
}

src_unpack() {
	default
}

src_prepare() {
	gnome2_omf_fix
	base_src_util autopatch
	eautoreconf
	elibtoolize
}

src_configure() {
	gnome2_src_configure
}

src_compile() {
	default
}

src_install() {
	gnome2_src_install
	make_desktop_entry "/usr/bin/passepartout" "Passepartout DTP" "" "GNOME;Application;Graphics" ""
}
