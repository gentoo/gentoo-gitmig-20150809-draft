# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gst-python/gst-python-0.8.2.ebuild,v 1.1 2005/06/22 14:09:42 zaheerm Exp $

inherit python

DESCRIPTION="A Python Interface to GStreamer"
HOMEPAGE="http://gstreamer.freedesktop.org"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"

RDEPEND=">=dev-python/pygtk-2.4
		>=dev-libs/glib-2
		>=x11-libs/gtk+-2
		>=media-libs/gstreamer-0.8.5
		>=media-libs/gst-plugins-0.8.5
		virtual/python"

DEPEND="${RDEPEND}
		dev-util/pkgconfig
		doc? ( app-text/xmlto
		       dev-libs/libxml2 )"

src_compile() {
	myconf=`use_enable doc docs`
	econf ${myconf} || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	docinto examples
	cp -a examples/* ${D}usr/share/doc/${PF}/examples
	prepalldocs
}

pkg_postinst() {
	python_version
	python_mod_optimize ${ROOT}usr/lib/python${PYVER}/site-packages/gst
}

pkg_postrm() {
	python_version
	python_mod_cleanup ${ROOT}usr/lib/python${PYVER}/site-packages/gst
}

