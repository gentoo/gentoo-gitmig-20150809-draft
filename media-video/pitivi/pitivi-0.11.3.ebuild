# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/pitivi/pitivi-0.11.3.ebuild,v 1.5 2009/05/03 17:36:25 eva Exp $

inherit gnome2 python eutils

DESCRIPTION="A non-linear video editor using the GStreamer multimedia framework"
HOMEPAGE="http://www.pitivi.org"
SRC_URI="mirror://gnome/sources/${PN}/0.11/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.5
	>=dev-python/pygtk-2.8.0
	dev-python/dbus-python
	>=dev-python/gconf-python-2.12
	dev-python/pycairo
	dev-python/pygoocanvas
	net-zope/zopeinterface

	>=media-libs/gstreamer-0.10.13.1
	>=dev-python/gst-python-0.10.6
	>=media-libs/gnonlin-0.10.10
	>=media-libs/gst-plugins-base-0.10.0
	>=media-libs/gst-plugins-good-0.10.0
	>=media-plugins/gst-plugins-ffmpeg-0.10.0
	>=media-plugins/gst-plugins-xvideo-0.10.0
	>=media-plugins/gst-plugins-libpng-0.10.0"
DEPEND="${RDEPEND}
	dev-python/setuptools
	>=dev-util/intltool-0.35.5"

DOCS="AUTHORS ChangeLog NEWS RELEASE"

src_unpack() {
	gnome2_src_unpack

	epatch "${FILESDIR}/${P}-reserved-word.patch" || die "epatch failed"

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

src_compile() {
	addpredict $(unset HOME; echo ~)/.gconf
	addpredict $(unset HOME; echo ~)/.gconfd
	addpredict $(unset HOME; echo ~)/.gstreamer-0.10
	gnome2_src_compile
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize "/usr/$(get_libdir)/${PN}/python/${PN}"
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup "/usr/$(get_libdir)/${PN}/python/${PN}"
}
