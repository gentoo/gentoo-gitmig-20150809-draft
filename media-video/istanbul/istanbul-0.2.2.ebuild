# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/istanbul/istanbul-0.2.2.ebuild,v 1.10 2012/10/25 20:50:59 eva Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2"

inherit eutils gnome2 python autotools

HOMEPAGE="http://live.gnome.org/Istanbul"
DESCRIPTION="Istanbul is a screencast application for the Unix desktop"
SRC_URI="http://zaheer.merali.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.8:0.10
	>=dev-python/pygtk-2.6
	>=gnome-base/gconf-2
	dev-python/gst-python:0.10
	media-plugins/gst-plugins-ogg:0.10
	media-plugins/gst-plugins-theora:0.10
	>=media-libs/libtheora-1.0_alpha6[encode]
	media-plugins/gst-plugins-gconf:0.10
	dev-python/python-xlib

	>=dev-python/egg-python-2.11.3
	>=dev-python/gnome-vfs-python-2
	>=dev-python/gconf-python-2"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
	echo "py_compile = $(type -P true)" > common/python.mk

	# fix autoreconf failure, bug #230325
	epatch "${FILESDIR}/${P}-macro-typo.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

src_configure() {
	mkdir -p "${T}/home"
	export HOME="${T}/home"
	export GST_REGISTRY=${T}/home/registry.cache.xml
	addpredict /root/.gconfd
	addpredict /root/.gconf
	addpredict /root/.gnome2

	gnome2_src_configure
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize istanbul
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup istanbul
}
