# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins-good/gst-plugins-good-0.10.6.ebuild,v 1.4 2007/09/09 14:04:30 drac Exp $

# order is important, gnome2 after gst-plugins
inherit gst-plugins-good gst-plugins10 gnome2 eutils flag-o-matic libtool

DESCRIPTION="Basepack of plugins for gstreamer"
HOMEPAGE="http://gstreamer.net/"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"

RDEPEND=">=media-libs/gst-plugins-base-0.10.13
	 >=media-libs/gstreamer-0.10.13
	 >=dev-libs/liboil-0.3.6"
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.11.5
	>=dev-util/pkgconfig-0.9
	!<media-libs/gst-plugins-bad-0.10.5"

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

	gst-plugins-good_src_configure

	emake || die
}

# override eclass
src_install() {
	gnome2_src_install
}

DOCS="AUTHORS README RELEASE"

pkg_postinst () {
	gnome2_pkg_postinst

	echo ""
	elog "The Gstreamer plugins setup has changed quite a bit on Gentoo,"
	elog "applications now should provide the basic plugins needed."
	elog ""
	elog "The new seperate plugins are all named 'gst-plugins-<plugin>'."
	elog "To get a listing of currently available plugins execute 'emerge -s gst-plugins-'."
	elog "In most cases it shouldn't be needed though to emerge extra plugins."
}

pkg_postrm() {
	gnome2_pkg_postrm
}
