# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.7.1-r2.ebuild,v 1.3 2006/04/05 18:25:57 dertobi123 Exp $

inherit eutils kde

DESCRIPTION="Media player for KDE using xine and gstreamer backends."
HOMEPAGE="http://kaffeine.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaffeine/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE="dvb gstreamer xinerama"

RDEPEND="|| ( x11-base/xorg-server
	      >=x11-base/xorg-x11-6.8.0-r4 )
	>=media-libs/xine-lib-1
	gstreamer? ( =media-libs/gstreamer-0.8*
		=media-libs/gst-plugins-0.8* )
	xinerama? ( || ( x11-libs/libXinerama virtual/x11 ) )"

DEPEND="${RDEPEND}
	xinerama? ( || ( x11-proto/xineramaproto virtual/x11 ) )
	dvb? ( >=sys-kernel/linux-headers-2.6 )
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
