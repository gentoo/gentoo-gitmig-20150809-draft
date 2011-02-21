# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/farsight2/farsight2-0.0.20.ebuild,v 1.6 2011/02/21 12:15:14 hwoarang Exp $

EAPI="2"
PYTHON_DEPEND="2"

inherit autotools eutils python

DESCRIPTION="Farsight2 is an audio/video conferencing framework specifically designed for Instant Messengers."
HOMEPAGE="http://farsight.freedesktop.org/"
SRC_URI="http://farsight.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="python test msn upnp"
SLOT="0"

# tests are sometimes broken (hopefully will be fixed by 0.0.21))
RESTRICT=test

COMMONDEPEND=">=media-libs/gstreamer-0.10.26
	>=media-libs/gst-plugins-base-0.10.26
	>=dev-libs/glib-2.16:2
	>=net-libs/libnice-0.0.9[gstreamer]
	python? (
		>=dev-python/pygobject-2.16:2
		>=dev-python/gst-python-0.10.10 )
	upnp? ( net-libs/gupnp-igd )"

RDEPEND="${COMMONDEPEND}
	>=media-libs/gst-plugins-good-0.10.17
	>=media-libs/gst-plugins-bad-0.10.17
	msn? ( >=media-plugins/gst-plugins-mimic-0.10.17 )"

DEPEND="${COMMONDEPEND}
	test? ( media-plugins/gst-plugins-vorbis
		media-plugins/gst-plugins-speex )
	dev-util/pkgconfig"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-make-382.patch
	eautoreconf
}

src_configure() {
	plugins="fsrtpconference,funnel,rtcpfilter,videoanyrate"
	use msn && plugins="${plugins},fsmsnconference"
	econf $(use_enable python) \
		$(use_enable upnp gupnp) \
		--with-plugins=${plugins}
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS README ChangeLog
}

src_test()
{
	use msn || { einfo "Tests disabled without msn use flag"; return ;}
	if ! emake -j1 check; then
		hasq test $FEATURES && die "Make check failed. See above for details."
		hasq test $FEATURES || eerror "Make check failed. See above for details."
	fi
}
