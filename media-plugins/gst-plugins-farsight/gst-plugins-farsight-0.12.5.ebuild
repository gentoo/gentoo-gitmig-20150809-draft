# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-farsight/gst-plugins-farsight-0.12.5.ebuild,v 1.2 2007/12/15 15:39:41 drac Exp $

inherit gst-plugins10

DESCRIPTION="GStreamer plugin for Farsight"
#HOMEPAGE="http://projects.collabora.co.uk/darcs/farsight/gst-plugins-farsight"
HOMEPAGE="http://farsight.freedesktop.org/"
SRC_URI="http://farsight.freedesktop.org/releases/${PN}/${P}.tar.gz"

GST_MAJOR=0.10
SLOT=${GST_MAJOR}

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="jpeg2k gsm jingle jrtplib msn yahoo"

DEPEND=">=media-libs/gstreamer-0.10.13
	>=media-libs/gst-plugins-base-0.10.13
	dev-libs/libxml2
	jpeg2k? ( media-libs/jasper )
	gsm? ( media-sound/gsm )
	jingle? ( net-libs/libjingle )
	msn? ( media-libs/libmimic )
	yahoo? ( media-libs/libj2k )
	jrtplib? ( dev-libs/jthread
		>=dev-libs/jrtplib-3.7.1 )"

RDEPEND="${DEPEND}"

src_compile() {
	econf \
		--enable-g729 \
		$(use_enable jpeg2k jasper) \
		$(use_enable gsm) \
		$(use_enable jingle jingle-p2p) \
		$(use_enable msn mimic) \
		$(use_with yahoo libj2k) \
		$(use_enable jrtplib) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}
