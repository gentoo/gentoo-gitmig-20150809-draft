# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gst-python/gst-python-0.10.21.ebuild,v 1.8 2011/10/23 22:36:31 tetromino Exp $

EAPI=3
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"
inherit autotools eutils python

DESCRIPTION="A Python Interface to GStreamer"
HOMEPAGE="http://gstreamer.freedesktop.org"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0.10"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="examples test"

RDEPEND="|| ( >=dev-python/pygobject-2.11.2:2 >=dev-python/pygtk-2.6.3 )
	>=media-libs/gstreamer-0.10.32
	>=media-libs/gst-plugins-base-0.10.32
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? (
		media-plugins/gst-plugins-ogg
		media-plugins/gst-plugins-vorbis
	)" # tests a "audiotestsrc ! vorbisenc ! oggmux ! fakesink" pipeline

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.10.9-lazy.patch
	rm -f py-compile ltmain.sh common/m4/{libtool,lt*}.m4 || die "rm -f failed"
	ln -s $(type -P true) py-compile
	AT_M4DIR="common/m4" eautoreconf
	python_src_prepare
}

src_install() {
	python_src_install
	dodoc AUTHORS ChangeLog NEWS README TODO

	if use examples; then
		docinto examples
		dodoc examples/*
	fi

	python_clean_installation_image
}

src_test() {
	LC_ALL="C" python_src_test
}

pkg_postinst() {
	python_mod_optimize pygst.py gst-0.10
}

pkg_postrm() {
	python_mod_cleanup pygst.py gst-0.10
}
