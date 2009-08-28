# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/listen/listen-0.6.3.ebuild,v 1.1 2009/08/28 14:07:58 ssuominen Exp $

EAPI=2
inherit eutils multilib python

DESCRIPTION="A Music player and management for GNOME"
HOMEPAGE="http://www.listen-project.org"
SRC_URI="http://download.listen-project.org/lastest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hal +libsexy musicbrainz webkit"

RDEPEND=">=dev-lang/python-2.5
	>=dev-python/pygtk-2.8:2
	dev-python/pyxdg
	|| ( dev-python/python-xlib dev-python/egg-python )
	dev-python/gnome-vfs-python
	|| ( x11-misc/notification-daemon x11-misc/xfce4-notifyd )
	media-libs/mutagen
	dev-python/gst-python:0.10
	media-plugins/gst-plugins-meta:0.10
	webkit? ( dev-python/pywebkitgtk )
	!webkit? ( dev-python/gtkmozembed-python )
	dev-python/pyinotify
	libsexy? ( dev-python/sexy-python )
	media-libs/libgpod[python]
	hal? ( sys-apps/hal )
	musicbrainz? ( <dev-python/python-musicbrainz-2005
		>=media-libs/tunepimp-0.5.3-r2[python] )"
DEPEND="${RDEPEND}
	app-text/docbook2X
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	!<media-sound/listen-0.6.2
	!media-radio/ax25-apps
	!dev-tinyos/listen"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.6.2-Makefile.patch
}

src_compile() {
	if use webkit; then
		CHECK_DEPENDS="0" emake || die "emake failed"
	else
		USE_GTKMOZEMBED="1" CHECK_DEPENDS="0" emake || die "emake failed"
	fi
}

src_install() {
	DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" emake \
		install || die "emake install failed"
	dodoc README
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
}
