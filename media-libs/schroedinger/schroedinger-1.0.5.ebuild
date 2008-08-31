# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/schroedinger/schroedinger-1.0.5.ebuild,v 1.5 2008/08/31 18:27:07 klausman Exp $

DESCRIPTION="C-based libraries and GStreamer plugins for the Dirac video codec"
HOMEPAGE="http://www.diracvideo.org"
SRC_URI="http://www.diracvideo.org/download/${PN}/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 LGPL-2.1 GPL-2 MIT )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="gstreamer"

RDEPEND=">=dev-libs/liboil-0.3.15
	gstreamer? ( >=media-libs/gst-plugins-base-0.10.12 )"
# Doesn't seem to build as of 1.0.5
#	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
		--disable-dependency-tracking \
		--disable-gtk-doc \
		$(use_enable gstreamer)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS TODO
}
