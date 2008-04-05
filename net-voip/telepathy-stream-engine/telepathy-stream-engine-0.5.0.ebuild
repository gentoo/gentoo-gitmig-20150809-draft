# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-stream-engine/telepathy-stream-engine-0.5.0.ebuild,v 1.1 2008/04/05 18:39:53 tester Exp $

DESCRIPTION="A Telepathy client that handles channels of type 'StreamedMedia'"
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/stream-engine/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug v4l v4l2 xv alsa esd oss"

DEPEND=">=dev-libs/glib-2.4
	dev-libs/libxml2
	>=media-libs/farsight-0.1.26
	=media-libs/gst-plugins-base-0.10*
	>=net-libs/telepathy-glib-0.7.1
	>=dev-libs/dbus-glib-0.71
	x11-libs/libX11"

RDEPEND="${DEPEND}
	media-plugins/gst-plugins-x
	v4l? ( media-plugins/gst-plugins-v4l )
	v4l2? ( media-plugins/gst-plugins-v4l2 )
	xv? ( media-plugins/gst-plugins-xvideo )
	alsa? ( media-plugins/gst-plugins-alsa )
	esd? ( media-plugins/gst-plugins-esd )
	oss? ( media-plugins/gst-plugins-oss )
	gnome? ( media-plugins/gst-plugins-gconf )
	pulseaudio? ( media-plugins/gst-plugins-pulse )"

src_compile() {
	econf \
		$(use_enable debug backtrace) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake failed"
	dodoc TODO ChangeLog
}
