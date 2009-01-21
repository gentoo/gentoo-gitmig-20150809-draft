# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdparanoia/gst-plugins-cdparanoia-0.10.14.ebuild,v 1.9 2009/01/21 23:31:31 aballier Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="media-sound/cdparanoia
	>=media-libs/gst-plugins-base-0.10.13.1"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
}

src_compile() {
	gst-plugins-base_src_configure
	# We need to build the entire set of plugins as well to satisfy the build.
	emake || die "emake failed."
}
