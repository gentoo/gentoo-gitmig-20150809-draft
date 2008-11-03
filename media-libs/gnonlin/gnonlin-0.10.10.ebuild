# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gnonlin/gnonlin-0.10.10.ebuild,v 1.1 2008/11/03 21:09:51 tester Exp $

DESCRIPTION="Gnonlin is a set of GStreamer elements to ease the creation of non-linear multimedia editors."
HOMEPAGE="http://gnonlin.sourceforge.net"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0.10"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/gstreamer-0.10.9
	 >=media-libs/gst-plugins-base-0.10.9"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README RELEASE
}
