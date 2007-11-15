# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.8.5-r1.ebuild,v 1.2 2007/11/15 20:16:26 flameeyes Exp $

inherit eutils kde flag-o-matic

DESCRIPTION="Media player for KDE using xine and gstreamer backends."
HOMEPAGE="http://kaffeine.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaffeine/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="dvb gstreamer xinerama vorbis encode kdehiddenvisibility xcb"

RDEPEND=">=media-libs/xine-lib-1
	xcb? ( >=x11-libs/libxcb-1.0
		>=media-libs/xine-lib-1.1.5 )
	gstreamer? ( =media-libs/gstreamer-0.10*
		=media-plugins/gst-plugins-xvideo-0.10* )
	media-sound/cdparanoia
	encode? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )
	x11-libs/libXtst"

DEPEND="${RDEPEND}
	dvb? ( media-tv/linuxtv-dvb-headers )"

need-kde 3.5.4

pkg_setup() {
	if use xcb && ! built_with_use --missing false media-libs/xine-lib xcb; then
		eerror "To enable the xcb useflag on this package you need"
		eerror "the useflag xcb enabled on media-libs/xine-lib."
		eerror "Please emerge media-libs/xine-lib again with the xcb useflag"
		eerror "enabled."
		die "Missing xcb useflag on media-libs/xine-lib."
	fi
}

src_unpack() {
	kde_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/kaffeine-with-xcb-r1.patch
	epatch "${FILESDIR}"/kaffeine-0.8.5-respectcflags.patch
	rm -f "${S}"/configure
}

src_compile() {
	# see bug #143168
	replace-flags -O3 -O2

	# Workarund bug #198973
	local save_CXXFLAGS="${CXXFLAGS}"
	append-flags -std=gnu89
	export CXXFLAGS="${save_CXXFLAGS}"

	local myconf="${myconf}
		$(use_with xinerama)
		$(use_with dvb)
		$(use_with gstreamer)
		$(use_with vorbis oggvorbis)
		$(use_with xcb)
		$(use_with encode lame)"

	kde_src_compile
}

src_install() {
	kde_src_install

	# Remove this, as kdelibs 3.5.4 provides it
	rm -f "${D}"/usr/share/mimelnk/application/x-mplayer2.desktop
}
