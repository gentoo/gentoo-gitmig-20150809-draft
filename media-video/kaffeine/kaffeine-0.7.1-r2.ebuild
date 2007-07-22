# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.7.1-r2.ebuild,v 1.6 2007/07/22 08:52:44 dberkholz Exp $

inherit eutils kde

DESCRIPTION="Media player for KDE using xine and gstreamer backends."
HOMEPAGE="http://kaffeine.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaffeine/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE="dvb gstreamer xinerama"

RDEPEND="x11-base/xorg-server
	>=media-libs/xine-lib-1
	gstreamer? ( =media-libs/gstreamer-0.8*
		=media-libs/gst-plugins-0.8* )
	xinerama? ( x11-libs/libXinerama )"

DEPEND="${RDEPEND}
	xinerama? ( x11-proto/xineramaproto )
	dvb? ( media-tv/linuxtv-dvb-headers )
	dev-util/pkgconfig"

# the dependency on xorg-x11 is meant to avoid bug #59746

PATCHES="${FILESDIR}/${P}-systemproto.patch
	${FILESDIR}/${P}-xinerama.patch
	${FILESDIR}/${P}-respectflags.patch
	${FILESDIR}/${P}-input-http.patch"

need-kde 3.2

src_compile() {
	rm ${S}/configure

	myconf="${myconf}
		$(use_with xinerama)
		$(use_with dvb)
		$(use_with gstreamer)"

	kde_src_compile
}
