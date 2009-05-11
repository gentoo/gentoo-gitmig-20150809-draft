# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gio/gst-plugins-gio-0.10.23.ebuild,v 1.1 2009/05/11 03:19:20 tester Exp $

inherit gst-plugins-base

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.23
	>=dev-libs/glib-2.15.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	gst-plugins-base_src_configure --enable-experimental
	gst-plugins10_find_plugin_dir
	emake || die "emake failed."
}
