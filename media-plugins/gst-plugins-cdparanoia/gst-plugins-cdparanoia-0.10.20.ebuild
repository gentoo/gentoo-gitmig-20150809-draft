# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdparanoia/gst-plugins-cdparanoia-0.10.20.ebuild,v 1.10 2009/04/02 20:27:44 tester Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.20
	media-sound/cdparanoia"
DEPEND="${RDEPEND}
	<media-libs/gstreamer-0.10.22
	dev-util/pkgconfig"

# Bypass eclass because entire set of plugins is required to satisfy the build.
src_unpack() {
	unpack ${A}
}

src_compile() {
	gst-plugins-base_src_configure
	emake || die "emake failed."
}
