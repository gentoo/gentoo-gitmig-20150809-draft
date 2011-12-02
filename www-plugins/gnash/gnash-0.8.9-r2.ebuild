# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/gnash/gnash-0.8.9-r2.ebuild,v 1.3 2011/12/02 19:26:32 beandog Exp $

EAPI=3
CMAKE_REQUIRED="never"
KDE_REQUIRED="optional"
AT_M4DIR="cygnal"

inherit autotools eutils kde4-base multilib nsplugins python flag-o-matic

DESCRIPTION="GNU Flash movie player that supports many SWF v7,8,9 features"
HOMEPAGE="http://www.gnu.org/software/gnash/"

if [[ ${PV} = 9999* ]]; then
	SRC_URI=""
	EGIT_REPO_URI="git://git.savannah.gnu.org/gnash.git"
	inherit git-2
else
	SRC_URI="mirror://gnu/${PN}/${PV}/${P}.tar.bz2"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="+agg cairo cygnal dbus doc fbcon +ffmpeg gnome gstreamer gtk kde lirc mysql +nls nsplugin opengl openvg python sdl +sdl-sound ssh ssl test vaapi"

# gnash fails if obsolete boost is installed, bug #334259
RDEPEND=">=dev-libs/boost-1.41.0
	!!dev-libs/boost:0
	dev-libs/expat
	dev-libs/libxml2
	virtual/jpeg
	media-libs/libpng
	net-misc/curl
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXt
	media-libs/giflib
	x11-proto/xproto
	agg? ( x11-libs/agg )
	cairo? ( x11-libs/cairo )
	doc? (
		>=app-text/docbook2X-0.8.8
		app-text/docbook-sgml-utils
	)
	fbcon? (
		x11-libs/tslib
	)
	ffmpeg? (
		virtual/ffmpeg[vaapi?]
	)
	gstreamer? (
		media-plugins/gst-plugins-ffmpeg
		media-plugins/gst-plugins-mad
		media-plugins/gst-plugins-meta
	)
	gtk? (
		x11-libs/gtk+:2
		net-libs/xulrunner:1.9
		python? ( dev-python/pygtk:2 )
	)
	kde? ( $(add_kdebase_dep kdebase-startkde) )
	opengl? (
		virtual/opengl
		gtk? ( x11-libs/gtkglext )
	)
	openvg? (
		virtual/opengl
	)
	nsplugin? ( >=net-libs/xulrunner-1.9.2:1.9 )
	sdl? ( media-libs/libsdl[X] )
	sdl-sound? ( media-libs/libsdl )
	media-libs/speex[ogg]
	sys-libs/zlib
	>=sys-devel/libtool-2.2
	mysql? ( virtual/mysql )
	lirc? ( app-misc/lirc )
	dbus? ( sys-apps/dbus )
	ssh?  ( >=net-libs/libssh-0.4[server] )
	ssl? ( dev-libs/openssl )
	vaapi? ( x11-libs/libva[opengl?] )
	"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	gnome? ( app-text/rarian )
	test? ( dev-util/dejagnu )"
# Tests hang with sandbox, bug #321017
RESTRICT="test"

pkg_setup() {
	if has_version ">=dev-libs/boost-1.46" && has_version "<dev-libs/boost-1.46"; then
		ewarn "If you have multiple versions of boost installed, gnash may attempt to"
		ewarn "compile against the older version and link against newer version, which can"
		ewarn "cause the build to fail. Unmerge of the old version of boost is recommended."
	fi

	if use !ffmpeg && use !gstreamer; then
		ewarn "You are trying to build Gnash without choosing a media handler."
		ewarn "Sound and video playback will not work."
	fi

	if use vaapi && use !ffmpeg; then
		eerror "Support for VAAPI currently requires the ffmpeg media handler."
		die "vaapi requires the ffmpeg USE flag."
	fi

	if use vaapi && use !agg; then
		eerror "Support for VAAPI currently requires the agg renderer."
		die "vaapi requires the agg USE flag."
	fi

	if use !agg && use !cairo && use !opengl && !use openvg; then
		eerror "You are trying to build Gnash without choosing a renderer [agg|cairo|opengl|openvg]."
		die "Please enable a renderer"
	fi

	if use !fbcon && use !kde && use !gtk && use !sdl; then
		ewarn "You are trying to build Gnash without choosing a gui frontend [fbcon,gtk,kde,sdl]."
		die "Please enable at least one of these USE flags."
	fi

	if use python && use !gtk; then
		eerror "Building gnash with python support requires gtk."
		die "python requires the gtk USE flag."
	fi

	if use nsplugin && use !gtk; then
		eerror "Building gnash with nsplugin requires the gtk gui."
		die "Nsplugin requires the gtk gui."
	fi

	if use fbcon && use !agg; then
		eerror "Building gnash with fbcon requires the agg renderer."
		die "fbcon requires the agg USE flag."
	fi

	kde4-base_pkg_setup
}

src_prepare() {
	# TODO: Patch no longer applies
#	epatch "${FILESDIR}"/${PN}-0.8.7-amf-include.patch

	# Look for openvg.h in correct path
	epatch "${FILESDIR}"/${PN}-0.8.9-find-openvg.patch

	# Fix paths for klash, bug #339610
	epatch "${FILESDIR}"/${PN}-0.8.9-klash.patch

	# Install documentation into the proper directories, bug #296110
	epatch "${FILESDIR}"/${PN}-0.8.9-documentation-paths.patch

	# Use external dejagnu for tests, bug #321017
	epatch "${FILESDIR}"/${PN}-0.8.9-external-dejagnu.patch

	# Fix detection of recent ffmpeg, bug #362683
	epatch "${FILESDIR}"/${PN}-0.8.9-ffmpeg-detection.patch
	epatch "${FILESDIR}"/${PN}-0.8.9-libavcodec-version.patch
	epatch "${FILESDIR}"/${PN}-0.8.9-look-harder-for-version_h.patch

	# Fix building against ffmpeg-0.8, bug #362949, upstream #33696
	epatch "${FILESDIR}"/${PN}-0.8.9-no-deprecated-avcodec-audio-resample.patch
	epatch "${FILESDIR}"/${PN}-0.8.9-no-deprecated-avcodec-decode-audio.patch
	epatch "${FILESDIR}"/${PN}-0.8.9-no-deprecated-avcodec-decode-video.patch
	epatch "${FILESDIR}"/${PN}-0.8.9-no-deprecated-avcodec-parser.patch
	epatch "${FILESDIR}"/${PN}-0.8.9-no-deprecated-avformat-metadata.patch

	# Fix building on ppc64, bug #342535
	use ppc64 && append-flags -mminimal-toc

	# Fix building of cygnal sshclient, bug #391915
	epatch "${FILESDIR}"/${PN}-0.8.9-cygnal-sshclient.patch

	# Fix kde multilib library path, bug #391283
	epatch "${FILESDIR}"/${PN}-0.8.9-kde4-libdir.patch

	# Fix security bug #391283
	epatch "${FILESDIR}"/${PN}-0.8.9-cve-2011-4328.patch

	eautoreconf
}
src_configure() {
	local gui hwaccel input media myconf myext renderers

	# Set nsplugin install directory.
	use nsplugin && myconf="${myconf} --with-npapi-plugindir=/usr/$(get_libdir)/gnash/npapi/"

	# Set hardware acceleration.
	if use vaapi; then
		hwaccel="vaapi"
	else
		hwaccel="none"
	fi

	# Set rendering engine.
	use agg && renderers+=",agg"
	use cairo && renderers+=",cairo"
	use opengl && renderers+=",opengl"
	use openvg && renderers+=",openvg"

	# Set kde and konqueror plugin directories.
	if use kde; then
		myconf="${myconf}
			--with-plugins-install=system
			--with-kde4-incl=${KDEDIR}/include
			--with-kde4-configdir=${KDEDIR}/share/config
			--with-kde4-prefix=${KDEDIR}
			--with-kde4-lib=${KDEDIR}/$(get_libdir)
			--with-kde-appsdatadir=${KDEDIR}/share/apps/klash
			--with-kde4-servicesdir=${KDEDIR}/share/kde4/services"
	fi

	# Set media handler.
	use ffmpeg || use gstreamer || media+=",none"
	use ffmpeg && media+=",ffmpeg"
	use gstreamer && media+=",gst"

	# Set gui.
	use gtk && gui=",gtk"
	use fbcon && gui="${gui},fb"
	use kde && gui="${gui},kde4"
	use sdl && gui="${gui},sdl"

	if use sdl-sound; then
		myconf="${myconf} --enable-sound=sdl"
	else
		myconf="${myconf} --enable-sound=none"
	fi

	# Set extensions
	use mysql && myext=",mysql"
	use gtk && myext="${myext},gtk"
	use lirc && myext="${myext},lirc"
	use dbus && myext="${myext},dbus"

	# Strip extra comma from gui, myext, hwaccel and renderers.
	gui=$( echo $gui | sed -e 's/,//' )
	hwaccel=$( echo $hwaccel | sed -e 's/,//' )
	myext=$( echo $myext | sed -e 's/,//' )
	renderers=$( echo $renderers | sed -e 's/,//' )
	media=$( echo $media | sed -e 's/,//' )

	econf \
		--docdir=/usr/share/doc/${PF} \
		--disable-dependency-tracking \
		--disable-kparts3 \
		$(use_enable cygnal) \
		$(use_enable cygnal cgibins) \
		$(use_enable doc docbook) \
		$(use_enable gnome ghelp) \
		$(use_enable kde kparts4) \
		$(use_enable lirc) \
		$(use_enable nls) \
		$(use_enable nsplugin npapi) \
		$(use_enable python) \
		$(use_enable ssh) \
		$(use_enable ssl) \
		$(use_enable test testsuite) \
		--enable-gui=${gui} \
		--enable-extensions=${myext} \
		--enable-renderer=${renderers} \
		--enable-hwaccel=${hwaccel} \
		--enable-media=${media} \
		${myconf}
}
src_test() {
	local log=testsuite-results.txt
	cd testsuite
	emake check || die "make check failed"
	./anaylse-results.sh > $log || die "results analyze failed"
	cat $log
}
src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# Install nsplugin in directory set by --with-npapi-plugindir.
	if use nsplugin; then
		emake DESTDIR="${D}" install-plugin || die "install plugins failed"
	fi

	# Install kde konqueror plugin.
	if use kde; then
		pushd "${S}/plugin/klash4" >& /dev/null || die
		emake DESTDIR="${D}" install-plugin || die "install kde plugins failed"
		popd >& /dev/null
	fi
	# Create a symlink in /usr/$(get_libdir)/nsbrowser/plugins to the nsplugin install directory.
	use nsplugin && inst_plugin /usr/$(get_libdir)/gnash/npapi/libgnashplugin.so \

	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
pkg_postinst() {
	if use !gnome || use !gstreamer && use !ffmpeg ; then
		ewarn ""
		ewarn "Gnash was built without a media handler and or http handler !"
		ewarn ""
		ewarn "If you want Gnash to support video then you will need to"
		ewarn "rebuild Gnash with either the ffmpeg or gstreamer and gnome use flags set."
		ewarn ""
	fi
	ewarn "${PN} is still in heavy development"
	ewarn "Please first report bugs on upstream gnashdevs and deal with them"
	ewarn "And then report a Gentoo bug to the maintainer"
	use kde && kde4-base_pkg_postinst
}
