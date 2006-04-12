# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/listen/listen-0.4.2-r2.ebuild,v 1.3 2006/04/12 05:51:57 bass Exp $

inherit eutils virtualx

DESCRIPTION="A Music player and management for GNOME"
HOMEPAGE="http://listengnome.free.fr"
SRC_URI="mirror://sourceforge/listengnome/${P}.tar.gz"

LICENSE="GPL-2"
IUSE="aac flac ipod mad vorbis"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=media-libs/gstreamer-0.10.0
	>=media-libs/gst-plugins-base-0.10.0
	>=media-libs/gst-plugins-good-0.10.0
	>=media-plugins/gst-plugins-gnomevfs-0.10.0
	>=media-plugins/gst-plugins-gconf-0.10.0
	>=media-plugins/gst-plugins-cdparanoia-0.10.0
	>=media-plugins/gst-plugins-xvideo-0.10.0
	mad? ( >=media-plugins/gst-plugins-mad-0.10.0 )
	vorbis? ( >=media-plugins/gst-plugins-ogg-0.10.0
			>=media-plugins/gst-plugins-vorbis-0.10.0 )
	flac? ( >=media-plugins/gst-plugins-flac-0.10.0 )
	aac? ( >=media-plugins/gst-plugins-faad-0.10.0
			dev-python/ctypes )
	ipod? ( >=media-libs/libgpod-0.3.2-r1 )
	cdr? ( app-cdr/serpentine )"

DEPEND="${RDEPEND}
	>=x11-libs/gtk+-2.8
	>=sys-apps/dbus-0.50
	>=dev-lang/python-2.3
	>=dev-python/pygtk-2.6
	>=dev-python/gst-python-0.10
	dev-python/pyvorbis
	dev-python/pymad
	>=dev-python/pysqlite-2.0
	dev-python/gnome-python-extras"


pkg_setup() {
	if ! built_with_use media-libs/libgpod python ; then
		echo
		eerror "In order to install iPod suport, you need to have media-libs/libgpod"
		eerror "with 'python' in your USE flags. Please add that flag,"
		eerror "re-emerge libgpod, and then emerge listen."
		die "media-libs/libgpod is missing the python binding."
	fi

	if ! built_with_use sys-apps/dbus python ; then
		echo
		eerror "In order to install Listen, you need to have sys-apps/dbus"
		eerror "with 'python' in your USE flags. Please add that flag,"
		eerror "re-emerge dbus, and then emerge listen."
		die "sys-apps/dbus is missing the python binding."
	fi

}

src_compile() {
	mkdir -p "${T}/home"
	export HOME="${T}/home"
	export GST_REGISTRY=${T}/home/registry.cache.xml
	addpredict /root/.gconfd
	addpredict /root/.gconf
	addpredict /var/lib/cache/gstreamer-0.10
	Xemake || die "make failed"
}

src_install() {
	Xmake DESTDIR="${D}" PREFIX="/usr" install || die "Install failure"
}
