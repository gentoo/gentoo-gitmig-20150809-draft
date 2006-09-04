# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gconf/gst-plugins-gconf-0.10.3.ebuild,v 1.12 2006/09/04 06:36:23 vapier Exp $

inherit gnome2 gst-plugins-good gst-plugins10

KEYWORDS="alpha amd64 arm hppa ~ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2.0
	>=media-libs/gstreamer-0.10.5
	>=media-libs/gst-plugins-base-0.10.6"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="gconf gconftool"

# override eclass
src_unpack() {
	unpack ${A}
}

src_compile() {
	gst-plugins-good_src_configure ${@}

	gst-plugins10_find_plugin_dir
	emake || die "compile failure"

	cd ${S}/gconf
	emake || die "compile failure"
}

src_install() {
	gst-plugins10_find_plugin_dir
	einstall || die

	cd ${S}/gconf
	gnome2_src_install || die
}
