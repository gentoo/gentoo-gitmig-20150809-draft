# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/listen/listen-0.5_beta1-r2.ebuild,v 1.1 2007/01/21 19:41:02 bass Exp $

inherit eutils virtualx

DESCRIPTION="A Music player and management for GNOME"
HOMEPAGE="http://listengnome.free.fr"
SRC_URI="mirror://sourceforge/listengnome/${PN}-0.5b1.tar.gz"
S="${WORKDIR}/${PN}-0.5b1"
LICENSE="GPL-2"
IUSE="aac cdr flac ipod mad vorbis"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND=">=media-libs/gst-plugins-base-0.10.0
	>=media-libs/gst-plugins-good-0.10.0
	>=media-plugins/gst-plugins-gnomevfs-0.10.0
	>=media-plugins/gst-plugins-gconf-0.10.0
	>=media-plugins/gst-plugins-cdparanoia-0.10.0
	>=media-plugins/gst-plugins-xvideo-0.10.0
	>=media-libs/mutagen-1.6
	>=dev-python/elementtree-1.2.6
	mad? ( >=media-plugins/gst-plugins-mad-0.10.0
			dev-python/pymad )
	vorbis? ( >=media-plugins/gst-plugins-ogg-0.10.0
			>=media-plugins/gst-plugins-vorbis-0.10.0
			dev-python/pyvorbis
			dev-python/pyogg )
	flac? ( >=media-plugins/gst-plugins-flac-0.10.0 )
	aac? ( >=media-plugins/gst-plugins-faad-0.10.0
			dev-python/ctypes )
	ipod? ( >=media-libs/libgpod-0.3.2-r1 )
	cdr? ( app-cdr/serpentine )"
#	musicbrainz? ( dev-python/python-musicbrainz
#			media-libs/tunepimp )

DEPEND="${RDEPEND}
	>=x11-libs/gtk+-2.8
	>=media-libs/gstreamer-0.10.0
	dev-python/dbus-python
	>=dev-lang/python-2.4
	>=dev-python/pygtk-2.6
	>=dev-python/gst-python-0.10
	>=dev-db/sqlite-3.2.7-r1
	>=dev-python/pysqlite-2.3.0
	>=media-libs/mutagen-1.6
	dev-python/gnome-python
	dev-python/gnome-python-extras"
#	libsexy? ( dev-python/sexy-python )

pkg_setup() {
	if use ipod && ! built_with_use media-libs/libgpod python ; then
		echo
		eerror "In order to install iPod suport, you need to have media-libs/libgpod"
		eerror "with 'python' in your USE flags. Please add that flag,"
		eerror "re-emerge libgpod, and then emerge listen."
		die "media-libs/libgpod is missing the python binding."
	fi

	if ! built_with_use gnome-base/gnome-vfs hal ; then
		echo
		eerror "In order to install Listen, you need to have gnome-base/gnome-vfs"
		eerror "with 'hal' in your USE flags. Please add that flag,"
		eerror "re-emerge gnome-vfs, and then emerge listen."
		die "gnome-base/gnome-vfs is missing the hal binding."
	fi
}

src_compile() {
	mkdir -p "${T}/home"
	export HOME="${T}/home"
	export GST_REGISTRY=${T}/home/registry.cache.xml
	addpredict /root/.gconfd
	addpredict /root/.gconf
	addpredict /var/lib/cache/gstreamer-0.10
	epatch "${FILESDIR}/check.patch"
	epatch "${FILESDIR}/Makefile.patch"
	sed -i "s:\$(PREFIX)/lib:\$(PREFIX)/$(get_libdir):g" Makefile
	Xemake -j1 || die "make failed"
}

src_install() {
	Xmake DESTDIR="${D}" PREFIX="/usr" install || die "Install failure"
}

pkg_postinst() {
	echo "#!/bin/sh" > /usr/bin/listen
	GTKMOZEMBED_PATH=$( pkg-config --libs-only-L mozilla-gtkmozembed 2>/dev/null || pkg-config --libs-only-L firefox-gtkmozembed 2>/dev/null | sed -e "s/-L//g" -e "s/[ ]/\,/" -e "s/[  ]//g" )
	echo "LD_LIBRARY_PATH=\"${GTKMOZEMBED_PATH}\"" "/usr/lib/listen/listen.py \"\$@\"" >> /usr/bin/listen

}

