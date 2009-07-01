# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdparanoia/gst-plugins-cdparanoia-0.10.22.ebuild,v 1.9 2009/07/01 16:33:41 armin76 Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.22
	>=media-sound/cdparanoia-3.10.2-r3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# Bypass eclass because entire set of plugins is required to satisfy the build.
src_unpack() {
	unpack ${A}
}

src_compile() {
	gst-plugins-base_src_configure
	emake || die "emake failed."
}
