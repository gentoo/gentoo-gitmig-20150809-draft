# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gst-python/gst-python-0.10.8.ebuild,v 1.4 2007/09/03 17:41:40 drac Exp $

NEED_PYTHON=2.3

inherit flag-o-matic python

DESCRIPTION="A Python Interface to GStreamer"
HOMEPAGE="http://gstreamer.freedesktop.org"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0.10"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-python/pygtk-2.6.3
	>=dev-libs/glib-2.8
	>=x11-libs/gtk+-2.6
	>=dev-python/pygobject-2.11.2
	>=media-libs/gstreamer-0.10.2
	>=media-libs/gst-plugins-base-0.10.0.2
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-text/xmlto )"

src_compile() {
	append-ldflags -Wl,-z,lazy
	econf $(use_enable doc docs) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	docinto examples
	cp -pPR examples/* ${D}usr/share/doc/${PF}/examples
	prepalldocs
}

pkg_postinst() {
	python_version
	python_mod_optimize ${ROOT}usr/lib/python${PYVER}/site-packages/gst-0.10
}

pkg_postrm() {
	python_version
	python_mod_cleanup ${ROOT}usr/lib/python${PYVER}/site-packages/gst-0.10
}
