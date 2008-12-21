# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gio/gst-plugins-gio-0.10.21-r1.ebuild,v 1.1 2008/12/21 17:36:30 ssuominen Exp $

inherit gst-plugins-base

KEYWORDS="~arm ~alpha ~amd64 ~hppa ~ia64 ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.21
	>=dev-libs/glib-2.15.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	gst-plugins-base_src_configure --enable-experimental
	gst-plugins10_find_plugin_dir
	emake || die "emake failed."
}
