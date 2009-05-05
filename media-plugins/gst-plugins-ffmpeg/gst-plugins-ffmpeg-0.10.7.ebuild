# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ffmpeg/gst-plugins-ffmpeg-0.10.7.ebuild,v 1.3 2009/05/05 19:56:06 ssuominen Exp $

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
KEYWORDS="alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${MY_P}

RDEPEND=">=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22
	>=dev-libs/liboil-0.3.6
	>=media-video/ffmpeg-0.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's,ffmpeg/avformat.h,libavformat/avformat.h,'		\
		-e 's,ffmpeg/avcodec.h,libavcodec/avcodec.h,'			\
		-e 's,ffmpeg/swscale.h,libswscale/swscale.h,'			\
		ext/ffmpeg/gst*							\
		ext/libpostproc/gstpostproc.c					\
		|| die "404. No files found."

}

src_compile() {
	append-flags -fno-strict-aliasing

	econf --with-system-ffmpeg
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
