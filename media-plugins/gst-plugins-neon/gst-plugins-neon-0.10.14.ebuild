# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.14.ebuild,v 1.8 2010/06/22 20:02:38 arfrever Exp $

inherit autotools gst-plugins-bad

KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=net-libs/neon-0.26
	>=media-libs/gstreamer-0.10.24
	>=media-libs/gst-plugins-base-0.10.24"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	gst-plugins-bad_src_unpack

	cd "${S}"
	# Support newer versions of net-libs/neon.
	sed -e "/NEON/s/0\.28\.99/0.30.99/" -i configure.ac || die "sed failed"
	eautoreconf
}
