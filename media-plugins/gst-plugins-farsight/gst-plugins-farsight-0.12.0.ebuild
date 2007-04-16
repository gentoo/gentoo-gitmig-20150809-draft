# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-farsight/gst-plugins-farsight-0.12.0.ebuild,v 1.1 2007/04/16 22:01:46 tester Exp $

inherit gst-plugins10

DESCRIPTION="GStreamer plugin for Farsight"
#HOMEPAGE="http://projects.collabora.co.uk/darcs/farsight/gst-plugins-farsight"
HOMEPAGE="http://farsight.freedesktop.org/"
SRC_URI="http://farsight.freedesktop.org/releases/${PN}/${P}.tar.gz"

GST_MAJOR=0.10
SLOT=${GST_MAJOR}

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="jrtplib jpeg2k gsm jingle msn yahoo"

DEPEND="=media-libs/gstreamer-${GST_MAJOR}*
	=media-libs/gst-plugins-base-${GST_MAJOR}*
	dev-libs/libxml2
	jrtplib? ( dev-libs/jthread
		>=dev-libs/jrtplib-3.5 )
	jpeg2k? ( media-libs/jasper )
	gsm? ( media-sound/gsm )
	jingle? ( net-libs/libjingle )
	msn? ( media-libs/libmimic )
	yahoo? ( media-libs/libj2k )"

RDEPEND="${DEPEND}"

src_compile() {
	econf \
		$(use_enable jrtplib) \
		$(use_enable jpeg2k jasper) \
		$(use_enable gsm) \
		$(use_enable jingle jingle-p2p) \
		$(use_enable msn mimic) \
		$(use_with yahoo libj2k) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}
