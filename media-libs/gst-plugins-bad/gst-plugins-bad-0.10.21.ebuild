# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins-bad/gst-plugins-bad-0.10.21.ebuild,v 1.3 2011/05/23 14:56:44 hwoarang Exp $

EAPI=1
GCONF_DEBUG="no"

inherit gst-plugins-bad gnome2 eutils flag-o-matic libtool

DESCRIPTION="Less plugins for GStreamer"
HOMEPAGE="http://gstreamer.freedesktop.org/"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="+orc"

RDEPEND=">=media-libs/gst-plugins-base-0.10.32
	>=media-libs/gstreamer-0.10.32
	>=dev-libs/glib-2.22
	orc? ( >=dev-lang/orc-0.4.7 )
	!<media-plugins/gst-plugins-farsight-0.12.11"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# Avoid --enable-bad passing by the eclass blindly
GST_PLUGINS_BUILD=""

src_compile() {
	strip-flags
	replace-flags "-O3" "-O2"
	filter-flags "-fprefetch-loop-arrays" # (Bug #22249)

	gst-plugins-bad_src_configure \
		$(use_enable orc) \
		--disable-examples \
		--disable-debug

	emake || die "emake failed."
}

src_install() {
	gnome2_src_install
}

DOCS="AUTHORS ChangeLog NEWS README RELEASE"

pkg_postinst() {
	gnome2_pkg_postinst
}

pkg_postrm() {
	gnome2_pkg_postrm
}
