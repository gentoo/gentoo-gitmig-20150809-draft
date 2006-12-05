# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/schroedinger/schroedinger-0.3.0.0.ebuild,v 1.1 2006/12/05 14:11:44 hanno Exp $

DESCRIPTION="C-based libraries and GStreamer plugins for the Dirac video codec"
HOMEPAGE="http://schrodinger.sourceforge.net/"
SRC_URI="mirror://sourceforge/schrodinger/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 LGPL-2.1 GPL-2 MIT )"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="debug profile examples doc"

RDEPEND=">=dev-libs/liboil-0.3.10
	doc? ( dev-util/gtk-doc )
	>=media-libs/gstreamer-0.10
	>=media-libs/gst-plugins-base-0.10
	profile? ( dev-util/valgrind )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable profile profiling) \
		$(use_enable profile valgrind) \
		$(use_enable profile gcov) \
		$(use_enable examples) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc ChangeLog
}
