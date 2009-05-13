# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gst-python/gst-python-0.10.15.ebuild,v 1.1 2009/05/13 15:46:37 tester Exp $

NEED_PYTHON=2.4

inherit autotools eutils multilib python

DESCRIPTION="A Python Interface to GStreamer"
HOMEPAGE="http://gstreamer.freedesktop.org"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0.10"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples"

RDEPEND="|| ( >=dev-python/pygobject-2.11.2 >=dev-python/pygtk-2.6.3 )
	>=media-libs/gstreamer-0.10.23
	>=media-libs/gst-plugins-base-0.10.23
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.10.9-lazy.patch

	eautoconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO

	if use examples; then
		docinto examples
		dodoc examples/*
	fi
}

pkg_postinst() {
	python_version
	python_mod_compile /usr/$(get_libdir)/python${PYVER}/site-packages/pygst.py
	python_mod_optimize	/usr/$(get_libdir)/python${PYVER}/site-packages/gst-0.10
}

pkg_postrm() {
	python_mod_cleanup
}
