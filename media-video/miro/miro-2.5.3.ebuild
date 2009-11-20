# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/miro/miro-2.5.3.ebuild,v 1.3 2009/11/20 14:47:44 scarabeus Exp $

EAPI="2"

inherit eutils fdo-mime gnome2-utils python distutils

DESCRIPTION="Open source video player and podcast client"
HOMEPAGE="http://www.getmiro.com/"
SRC_URI="http://ftp.osuosl.org/pub/pculture.org/${PN}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+gstreamer libnotify"

CDEPEND="
	dev-libs/boost[python]
	dev-libs/glib:2
	dev-python/pygobject:2
	dev-python/pygtk:2
	media-libs/xine-lib
	>=net-libs/rb_libtorrent-0.14.1[python]
	|| ( net-libs/xulrunner:1.9 net-libs/xulrunner:1.8 )
	x11-libs/gtk+:2
	x11-libs/libX11"
RDEPEND="${CDEPEND}
	gstreamer? ( dev-python/gst-python:0.10 )
	libnotify? ( dev-python/notify-python )
	|| ( dev-lang/python[sqlite] dev-python/pysqlite:2 )
	dev-python/dbus-python
	dev-python/gconf-python
	dev-python/gtkmozembed-python
	dev-python/pycairo"
DEPEND="${CDEPEND}
	>=dev-python/pyrex-0.9.6.4
	dev-util/pkgconfig"

S="${WORKDIR}/${P}/platform/gtk-x11"

# NOTES:
# it's probably not working with python-3
# used xulrunner has to be the same as the one used for gtkmozembed-python
# psyco can make miro speedier, add a USE flag, recommand in postinst ?

# TODO:
# create a real test suite
# try to have a real xine/gstreamer choice

src_prepare() {
	# install only needed locales
	epatch "${FILESDIR}"/${P}-fix-locale.patch
	# fix debug mode
	epatch "${FILESDIR}"/${P}-fix-debug.patch
	# disable xine hack which is failing
	epatch "${FILESDIR}"/${P}-disable-xine-hack.patch
	# prevent installing unneeded test files
	epatch "${FILESDIR}"/${P}-dont-install-test-files.patch
	# do not show --unittest option
	epatch "${FILESDIR}"/${P}-remove-unittest-option.patch

	# disable autoupdate
	sed -i -e "/autoupdate/d" ../../portable/startup.py || die "sed failed"

	# be sure libnotify is never used if disabled
	if ! use libnotify; then
		sed -i -e "s:import pynotify:import pynotifyisdisabled:" \
			../../portable/frontends/widgets/gtk/trayicon.py \
			plat/frontends/widgets/application.py || die "sed failed"
	fi

	# set xine as the default renderer if gstreamer is disabled
	if ! use gstreamer; then
		sed -i -e "s:default=u\"gstreamer\":default=u\"xine\":" \
			|| die "sed failed"
	fi
}

src_test() {
	# there is a test suite but it has been designed to be used when installed
	# should be fixed
	:
}

src_install() {
	# doing the mv now otherwise, distutils_src_install will install it
	mv README README.gtk || die "mv failed"

	distutils_src_install

	# installing docs
	dodoc README.gtk ../../{ADOPTERS,CREDITS,README} || die "dodoc failed"
	newdoc ../../portable/frontends/cli/README README.cli || die "dodoc failed"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	distutils_pkg_postinst
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update

	elog "If you can't see a video or can't heard an audio,"
	elog "enable needed media-libs/xine-lib USE flags"
	elog "or install required gstreamer plugins"
}

pkg_postrm() {
	distutils_pkg_postrm
	gnome2_icon_cache_update
}
