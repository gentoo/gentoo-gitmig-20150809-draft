# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.8.3-r1.ebuild,v 1.1 2007/02/09 04:47:59 flameeyes Exp $

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
		>=media-libs/xine-lib-1.1.4-r1 )
	gstreamer? ( =media-libs/gstreamer-0.8*
		=media-libs/gst-plugins-0.8*
		=media-plugins/gst-plugins-xvideo-0.8* )
	media-sound/cdparanoia
	encode? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )
	x11-libs/libXtst"

DEPEND="${RDEPEND}
	dvb? ( media-tv/linuxtv-dvb-headers )"

PATCHES="${FILESDIR}/${P}-build.patch"

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

	use xcb && epatch "${FILESDIR}/${P}-xcb.patch"
}

src_compile() {
	# see bug #143168
	replace-flags -O3 -O2

	local myconf="${myconf}
		$(use_with xinerama)
		$(use_with dvb)
		$(use_with gstreamer)
		$(use_with vorbis oggvorbis)
		$(use_with encode lame)"

	kde_src_compile
}

src_install() {
	kde_src_install

	# Remove this, as kdelibs 3.5.4 provides it
	rm -f "${D}/usr/share/mimelnk/application/x-mplayer2.desktop"
}
