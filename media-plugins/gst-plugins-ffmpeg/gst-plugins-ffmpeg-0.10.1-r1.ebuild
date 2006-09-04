# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ffmpeg/gst-plugins-ffmpeg-0.10.1-r1.ebuild,v 1.8 2006/09/04 06:42:34 vapier Exp $

inherit flag-o-matic eutils

MY_PN=${PN/-plugins/}
MY_P=${MY_PN}-${PV}

# Create a major/minor combo for SLOT
PVP=(${PV//[-\._]/ })
SLOT=${PVP[0]}.${PVP[1]}
#SLOT=0.10

DESCRIPTION="FFmpeg based gstreamer plugin"
HOMEPAGE="http://gstreamer.freedesktop.org/modules/gst-ffmpeg.html"
SRC_URI="http://gstreamer.freedesktop.org/src/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 arm hppa ~ia64 ppc ppc64 x86"
IUSE=""

S=${WORKDIR}/${MY_P}

DEPEND=">=media-libs/gstreamer-0.10.0
	>=media-libs/gst-plugins-base-0.10.0
	dev-util/pkgconfig"

src_compile() {
	# Restrictions taken from the mplayer ebuild
	# See bug #64262 for more info
	# let's play the filtration game!
	filter-flags -fPIE -fPIC -fstack-protector -fforce-addr -momit-leaf-frame-pointer -msse2 -msse3 -falign-functions -fweb
	# ugly optimizations cause MPlayer to cry on x86 systems!
	if use x86 ; then
		replace-flags -O0 -O2
		replace-flags -O3 -O2
	fi

	econf --disable-ffplay|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
