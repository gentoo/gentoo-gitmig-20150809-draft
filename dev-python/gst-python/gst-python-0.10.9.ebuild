# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gst-python/gst-python-0.10.9.ebuild,v 1.3 2007/12/13 19:02:58 drac Exp $

NEED_PYTHON=2.3

inherit autotools eutils multilib python

DESCRIPTION="A Python Interface to GStreamer"
HOMEPAGE="http://gstreamer.freedesktop.org"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0.10"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.6.3
	>=dev-libs/glib-2.8
	>=x11-libs/gtk+-2.6
	>=dev-python/pygobject-2.11.2
	>=media-libs/gstreamer-0.10.2
	>=media-libs/gst-plugins-base-0.10.0.2
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-lazy.patch
	AT_M4DIR="common/m4" eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
	docinto examples
	cp -pPR examples/* "${D}"/usr/share/doc/${PF}/examples
	prepalldocs
}

pkg_postinst() {
	python_version
	python_mod_optimize	"${ROOT}"usr/$(get_libdir)/python${PYVER}/site-packages/gst-0.10
}

pkg_postrm() {
	python_mod_cleanup
}
