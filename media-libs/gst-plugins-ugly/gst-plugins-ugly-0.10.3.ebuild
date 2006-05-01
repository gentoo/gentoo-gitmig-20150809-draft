# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins-ugly/gst-plugins-ugly-0.10.3.ebuild,v 1.4 2006/05/01 10:45:32 corsair Exp $

# order is important, gnome2 after gst-plugins
inherit gst-plugins-ugly gst-plugins10 gnome2 eutils flag-o-matic libtool

DESCRIPTION="Basepack of plugins for gstreamer"
HOMEPAGE="http://gstreamer.net/"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
#IUSE="esd alsa oss"

RDEPEND=">=media-libs/gst-plugins-base-0.10.3
	 >=media-libs/gstreamer-0.10.3
	 >=dev-libs/liboil-0.3.0
	 >=dev-libs/glib-2.6.0"

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.11.5
	>=dev-util/pkgconfig-0.9"

#PDEPEND="oss? ( >=media-plugins/gst-plugins-oss-${PV} )
#	alsa? ( >=media-plugins/gst-plugins-alsa-${PV} )
#	esd? ( >=media-plugins/gst-plugins-esd-${PV} )"

GST_PLUGINS_BUILD=""

# overrides the eclass
src_unpack() {

	unpack ${A}
}

src_compile() {

	elibtoolize

	# gst doesnt handle optimisations well
	strip-flags
	replace-flags "-O3" "-O2"
	filter-flags "-fprefetch-loop-arrays" # see bug 22249
	if use alpha || use amd64 || use ia64 || use hppa; then
		append-flags -fPIC
	fi

	gst-plugins-ugly_src_configure

	emake || die

}

# override eclass
src_install() {

	gnome2_src_install

}

DOCS="AUTHORS INSTALL README RELEASE TODO"

pkg_postinst () {

	gnome2_pkg_postinst

	echo ""
	einfo "The Gstreamer plugins setup has changed quite a bit on Gentoo,"
	einfo "applications now should provide the basic plugins needed."
	echo ""
	einfo "The new seperate plugins are all named 'gst-plugins-<plugin>'."
	einfo "To get a listing of currently available plugins execute 'emerge -s gst-plugins-'."
	einfo "In most cases it shouldn't be needed though to emerge extra plugins."

}

pkg_postrm() {

	gnome2_pkg_postrm

}
