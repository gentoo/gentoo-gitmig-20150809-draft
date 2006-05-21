# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-farsight/gst-plugins-farsight-0.10.2_p20060521.ebuild,v 1.1 2006/05/21 14:43:20 genstef Exp $

inherit gst-plugins10

DESCRIPTION="GStreamer plugin for Farsight"
HOMEPAGE="http://projects.collabora.co.uk/darcs/farsight/gst-plugins-farsight"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~genstef/files/dist/${P}.tar.bz2"

# Create a major/minor combo for SLOT - stolen from gst-plugins-ffmpeg
PVP=(${PV//[-\._]/ })
SLOT=${PVP[0]}.${PVP[1]}

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="jrtplib jpeg2k gsm jingle"

DEPEND="=media-libs/gstreamer-0.10*
	=media-libs/gst-plugins-base-0.10*
	dev-libs/libxml2
	jrtplib? ( dev-libs/jthread
		>=dev-libs/jrtplib-3.5 )
	jpeg2k? ( media-libs/jasper )
	gsm? ( media-sound/gsm )
	jingle? ( net-libs/libjingle )"
#	Does not compile: media-libs/libj2k
#	--with-libj2k \

src_compile() {
	NOCONFIGURE=1 ./autogen.sh
	econf \
		$(use_enable jrtplib) \
		$(use_enable jpeg2k jasper) \
		$(use_enable gsm) \
		$(use_enable jingle jingle-p2p) \
		--disable-debug \
		--disable-mimic \
		--with-plugins=rtpdemux,rtpjitterbuffer || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
