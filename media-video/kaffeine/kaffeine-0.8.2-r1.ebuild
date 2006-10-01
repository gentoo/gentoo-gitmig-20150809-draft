# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.8.2-r1.ebuild,v 1.2 2006/10/01 17:49:34 flameeyes Exp $

inherit eutils kde

DESCRIPTION="Media player for KDE using xine and gstreamer backends."
HOMEPAGE="http://kaffeine.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaffeine/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="dvb gstreamer xinerama vorbis encode kdehiddenvisibility"

RDEPEND="|| ( x11-base/xorg-server
		  >=x11-base/xorg-x11-6.8.0-r4 )
	>=media-libs/xine-lib-1
	gstreamer? ( =media-libs/gstreamer-0.8*
		=media-libs/gst-plugins-0.8*
		=media-plugins/gst-plugins-xvideo-0.8* )
	media-sound/cdparanoia
	encode? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )
	|| ( (
			x11-libs/libXtst
			xinerama? ( x11-libs/libXinerama )
		) <virtual/x11-7 )"

DEPEND="${RDEPEND}
	xinerama? ( || ( x11-proto/xineramaproto <virtual/x11-7 ) )
	dvb? ( media-tv/linuxtv-dvb-headers )
	dev-util/pkgconfig"

# the dependency on xorg-x11 is meant to avoid bug #59746

need-kde 3.5.4

S="${WORKDIR}/${PN}"

src_unpack() {
	kde_src_unpack

	# Workaround incomplete autotools support from upstream
	mv "${P}" "${PN}"
}

src_compile() {
	# It re-runs configure because of messed-up timestamps
	rm -f "${S}/configure"

	myconf="${myconf}
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
