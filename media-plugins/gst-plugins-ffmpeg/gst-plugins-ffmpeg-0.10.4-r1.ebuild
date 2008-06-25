# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ffmpeg/gst-plugins-ffmpeg-0.10.4-r1.ebuild,v 1.2 2008/06/25 20:13:38 loki_val Exp $

inherit flag-o-matic eutils base

PD=${FILESDIR}/${PV}
MY_PN=${PN/-plugins}
MY_P=${MY_PN}-${PV}

# Create a major/minor combo for SLOT
PVP=(${PV//[-\._]/ })
SLOT=${PVP[0]}.${PVP[1]}
#SLOT=0.10

DESCRIPTION="FFmpeg based gstreamer plugin"
HOMEPAGE="http://gstreamer.freedesktop.org/modules/gst-ffmpeg.html"
SRC_URI="http://gstreamer.freedesktop.org/src/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${MY_P}

RDEPEND=">=media-libs/gstreamer-0.10.4
	>=media-libs/gst-plugins-base-0.10.4
	>=dev-libs/liboil-0.3.6
	>=media-video/ffmpeg-0.4.9_p20080326"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PATCHES=(	"${PD}/01_new-codec-ids.patch"
		"${PD}/02_av_picture_copy.patch"
		"${PD}/03_disable-aac.patch"
		"${PD}/04_disable-mpegts.patch"
		"${PD}/system-ffmpeg-warning.patch"	 )

src_unpack() {
	unpack ${A}
	cd "${S}"
	base_src_unpack autopatch
	sed -i \
		-e 's,ffmpeg/avformat.h,libavformat/avformat.h,'		\
		-e 's,ffmpeg/avcodec.h,libavcodec/avcodec.h,'			\
		-e 's,ffmpeg/swscale.h,libswscale/swscale.h,'			\
		-e 's,postproc/postprocess.h,libpostproc/postprocess.h,'	\
		ext/ffmpeg/gst*							\
		ext/libpostproc/gstpostproc.c					\
		|| die "404. No files found."
}

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

	econf --with-system-ffmpeg
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
