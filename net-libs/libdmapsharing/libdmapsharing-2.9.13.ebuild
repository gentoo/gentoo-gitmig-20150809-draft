# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libdmapsharing/libdmapsharing-2.9.13.ebuild,v 1.2 2012/05/03 23:43:53 tetromino Exp $

EAPI="4"

DESCRIPTION="A library that implements the DMAP family of protocols"
HOMEPAGE="http://www.flyn.org/projects/libdmapsharing"
SRC_URI="http://www.flyn.org/projects/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="3.0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

# Vala/libgee/gtk+:2 is only used when maintainer-mode is enabled
# Doesn't seem to be used for anything...
# TODO: implement tests (requires dev-libs/check)
RDEPEND="
	dev-libs/glib:2
	x11-libs/gdk-pixbuf:2

	>=net-dns/avahi-0.6
	>=net-libs/libsoup-2.32:2.4
	>=media-libs/gstreamer-0.10:0.10
	>=media-libs/gst-plugins-base-0.10.24:0.10

	sys-libs/zlib
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )
"

src_prepare() {
	default

	# Fix documentation sloting
	sed "s/^\(DOC_MODULE\).*/\1 = ${PN}-${SLOT}/" \
		-i doc/Makefile.am doc/Makefile.in || die "sed failed"
}

src_configure() {
	econf --disable-maintainer-mode \
		--with-mdns=avahi \
		$(use_enable doc gtk-doc)
}

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die "la file removal failed"
}
