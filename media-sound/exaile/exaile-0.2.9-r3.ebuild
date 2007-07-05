# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/exaile/exaile-0.2.9-r3.ebuild,v 1.2 2007/07/05 18:21:56 drac Exp $

inherit eutils fdo-mime python toolchain-funcs

GVER="0.10"

MY_P=${PN}_${PV}

DESCRIPTION="a media player aiming to be similar to AmaroK, but for GTK+"
HOMEPAGE="http://www.exaile.org/"
SRC_URI="http://www.exaile.org/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="aac alsa cdparanoia flac gnome ipod libnotify libsexy mad musepack ogg
	oss serpentine streamripper vorbis"

RDEPEND=">=dev-python/pygtk-2.8.6
	>=dev-python/pysqlite-2
	>=media-libs/mutagen-1.6
	dev-python/elementtree
	>=gnome-base/librsvg-2
	dev-python/dbus-python
	libnotify? ( dev-python/notify-python )
	libsexy? ( dev-python/sexy-python )
	gnome? ( >=dev-python/gnome-python-extras-2.14
		>=media-plugins/gst-plugins-gconf-${GVER}
		>=media-plugins/gst-plugins-gnomevfs-${GVER} )
	serpentine? ( app-cdr/serpentine )
	streamripper? ( media-sound/streamripper )
	>=media-libs/gstreamer-${GVER}
	>=media-libs/gst-plugins-good-${GVER}
	>=dev-python/gst-python-${GVER}
	musepack? ( >=media-plugins/gst-plugins-musepack-${GVER} )
	vorbis? ( >=media-plugins/gst-plugins-vorbis-${GVER} )
	flac? ( >=media-plugins/gst-plugins-flac-${GVER} )
	aac? ( >=media-plugins/gst-plugins-faad-${GVER} )
	alsa? ( >=media-plugins/gst-plugins-alsa-${GVER} )
	oss? ( >=media-plugins/gst-plugins-oss-${GVER} )
	mad? ( >=media-plugins/gst-plugins-mad-${GVER} )
	ogg? ( >=media-plugins/gst-plugins-ogg-${GVER} )
	cdparanoia? ( >=media-plugins/gst-plugins-cdparanoia-${GVER}
		dev-python/cddb-py )
	ipod? ( >=media-libs/libgpod-0.4
		>=media-plugins/gst-plugins-faad-${GVER} )"
DEPEND=""

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use ipod && ! built_with_use media-libs/libgpod python ; then
		eerror "libgpod has to be built with python support"
		die "libgpod python use-flag not set"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.2.x-strip.patch
	epatch "${FILESDIR}"/${P}-amazon.patch
	python_version
	sed -i -e "s:hon2.4:hon${PYVER}:" mmkeys/Makefile
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc testing TODO
	exeinto /usr/share/${PN}
	doexe scripts/*
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"/usr/share/${PN}
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/share/${PN}
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
