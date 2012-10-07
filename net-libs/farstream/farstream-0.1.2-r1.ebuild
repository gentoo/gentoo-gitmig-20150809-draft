# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/farstream/farstream-0.1.2-r1.ebuild,v 1.7 2012/10/07 01:04:14 blueness Exp $

EAPI="4"
PYTHON_DEPEND="2"

inherit eutils python

DESCRIPTION="Farsight2 is an audio/video conferencing framework specifically designed for Instant Messengers."
HOMEPAGE="http://farsight.freedesktop.org/"
SRC_URI="http://farsight.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="+introspection python msn test upnp"

SLOT="0"

# Tests need shmsink from gst-plugins-bad, which isn't packaged
RESTRICT="test"

COMMONDEPEND=">=media-libs/gstreamer-0.10.33:0.10
	>=media-libs/gst-plugins-base-0.10.33:0.10
	>=dev-libs/glib-2.26:2
	>=net-libs/libnice-0.1.0[gstreamer]
	introspection? ( >=dev-libs/gobject-introspection-0.10.11 )
	python? (
		>=dev-python/pygobject-2.16:2
		>=dev-python/gst-python-0.10.10 )
	upnp? ( net-libs/gupnp-igd )"

RDEPEND="${COMMONDEPEND}
	>=media-libs/gst-plugins-good-0.10.17:0.10
	>=media-libs/gst-plugins-bad-0.10.17
	msn? ( >=media-plugins/gst-plugins-mimic-0.10.17:0.10 )
	!net-libs/farsight2"
# This package is just a rename from farsight2

DEPEND="${COMMONDEPEND}
	virtual/pkgconfig
	test? (
		media-libs/gst-plugins-good:0.10
		media-plugins/gst-plugins-vorbis:0.10 )"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	# Fix building with gobject-introspection-1.33.x, bug #425096
	epatch "${FILESDIR}/${P}-introspection-tag-order.patch"
}

src_configure() {
	plugins="fsrawconference,fsrtpconference,fsfunnel,fsrtcpfilter,fsvideoanyrate"
	use msn && plugins="${plugins},fsmsnconference"
	econf --disable-static \
		$(use_enable introspection) \
		$(use_enable python) \
		$(use_enable upnp gupnp) \
		--with-plugins=${plugins}
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc AUTHORS README ChangeLog

	# Remove .la files since static libs are no longer being installed
	find "${D}" -name '*.la' -exec rm -f '{}' + || die
}

src_test() {
	# FIXME: do an out-of-tree build for tests if USE=-msn
	if ! use msn; then
		elog "Tests disabled without msn use flag"
		return
	fi

	emake -j1 check
}
