# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/listen/listen-0.6.5.ebuild,v 1.5 2010/11/03 11:43:30 ssuominen Exp $

EAPI=2

PYTHON_DEPEND="2:2.6"

inherit eutils multilib python

DESCRIPTION="A Music player and management for GNOME"
HOMEPAGE="http://www.listen-project.org/"
SRC_URI="http://download.listen-project.org/0.6/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome +libsexy musicbrainz webkit"

RDEPEND="dev-python/dbus-python
	>=dev-python/pygtk-2.8:2
	dev-python/pyxdg
	|| ( dev-python/python-xlib dev-python/egg-python )
	gnome? ( dev-python/gnome-vfs-python )
	x11-libs/libnotify
	media-libs/mutagen
	dev-python/gst-python:0.10
	media-plugins/gst-plugins-meta:0.10
	webkit? ( dev-python/pywebkitgtk )
	!webkit? ( dev-python/gtkmozembed-python )
	dev-python/pyinotify
	libsexy? ( dev-python/sexy-python )
	media-libs/libgpod[python]
	musicbrainz? ( <dev-python/python-musicbrainz-2005
		>=media-libs/tunepimp-0.5.3-r2[python] )"
DEPEND="${RDEPEND}
	app-text/docbook2X
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	!media-radio/ax25-apps
	!dev-tinyos/listen"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	if use webkit; then
		CHECK_DEPENDS="0" emake PYTHON="$(PYTHON)" || die
	else
		USE_GTKMOZEMBED="1" CHECK_DEPENDS="0" emake PYTHON="$(PYTHON)" || die
	fi
}

src_test() { :; } #324719

src_install() {
	DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" emake \
		install || die
	dodoc README
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
}
