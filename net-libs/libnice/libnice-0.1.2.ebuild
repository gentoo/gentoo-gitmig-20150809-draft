# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnice/libnice-0.1.2.ebuild,v 1.9 2012/10/28 16:24:58 armin76 Exp $

EAPI="4"

DESCRIPTION="An implementation of the Interactice Connectivity Establishment standard (ICE)"
HOMEPAGE="http://nice.freedesktop.org/wiki/"
SRC_URI="http://nice.freedesktop.org/releases/${P}.tar.gz"

LICENSE="LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="+gstreamer upnp"

RDEPEND=">=dev-libs/glib-2.13:2
	gstreamer? (
		media-libs/gstreamer:0.10
		media-libs/gst-plugins-base:0.10 )
	upnp? ( >=net-libs/gupnp-igd-0.1.3 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf --disable-static \
		$(use_with gstreamer) \
		$(use_enable upnp gupnp)
}

src_install() {
	default

	# Remove .la files since static libs are no longer being installed
	find "${D}" -name '*.la' -exec rm -f '{}' + || die
}
