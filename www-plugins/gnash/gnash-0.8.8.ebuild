# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/gnash/gnash-0.8.8.ebuild,v 1.13 2010/12/06 22:44:21 chithanh Exp $

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
	inherit git
else
	SRC_URI="mirror://gnu/${PN}/${PV}/${P}.tar.bz2"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="+agg cairo cygnal dbus doc fbcon +ffmpeg gnome gstreamer gtk kde lirc mysql +nls nsplugin opengl python +sdl sdl-sound ssh ssl test vaapi video_cards_intel xv"

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
	x11-libs/libXv
	media-libs/giflib
	x11-proto/xproto
	agg? ( x11-libs/agg )
	cairo? ( x11-libs/cairo )
	doc? (
		>=app-text/docbook2X-0.8.8
		app-text/docbook-sgml-utils
	)
	ffmpeg? (
		media-video/ffmpeg[vaapi?]
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
	kde? ( >=kde-base/kdebase-startkde-${KDE_MINIMAL} )
	opengl? (
		virtual/opengl
		gtk? ( x11-libs/gtkglext )
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
	xv? ( x11-libs/libXv )
	"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	gnome? ( app-text/rarian )
	test? ( dev-util/dejagnu )"
# Tests hang with sandbox, bug #321017
RESTRICT="test"

pkg_setup() {
	if use !ffmpeg && use !gstreamer; then
		ewarn "You are trying to build Gnash without choosing a media handler."
		ewarn "Sound and video playback will not work."
	fi

	if use vaapi && use !ffmpeg; then
		eerror "Support for VAAPI currently requires the ffmpeg media handler."
		die "vaapi requires the ffmpeg USE flag."
	fi

	if use xv && use !opengl; then
		eerror "Support for xvideo currently requires the opengl renderer."
		die "xv requires the opengl USE flag."
	fi

	if use !agg && use !cairo && use !opengl; then
		eerror "You are trying to build Gnash without choosing a renderer [agg|cairo|opengl]."
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

	if use sdl; then
		einfo "Enable SDL as gui frontend and sound handler"
	fi

	if use lirc; then
		einfo "Enable LIRC daemon support and lirc extension"
	fi

	kde4-base_pkg_setup
}

src_prepare() {
	# TODO: Patch no longer applies
#	epatch "${FILESDIR}"/${PN}-0.8.7-amf-include.patch

	# Resurect patch from bug #230287
	epatch "${FILESDIR}"/${PN}-0.8.3-boost-dynamic-link.patch

	# Adapted from Alt Linux to fix klash support properly
	epatch "${FILESDIR}"/${PN}-0.8.8-klash.patch

	# Make gnash find moc and uic properly, upstream bug #25758,
	# gentoo bug #283905
	epatch "${FILESDIR}"/${PN}-0.8.7-moc-qt4.patch

	# Install documentation into the proper directories, bug #296110
	epatch "${FILESDIR}"/${PN}-0.8.8-documentation-paths.patch

	# Use external dejagnu for tests, bug #321017
	epatch "${FILESDIR}"/${PN}-0.8.8-external-dejagnu.patch

	# Fix building on ppc64, bug #342535
	use ppc64 && append-flags -mminimal-toc

	eautoreconf
}
src_configure() {
	local gui hwaccel input media myconf myext renderers

	# Set nsplugin install directory.
	use nsplugin && myconf="${myconf} --with-npapi-plugindir=/usr/$(get_libdir)/gnash/npapi/"

	# Set hardware acceleration.
	use xv && hwaccel+=",xv"
	use vaapi && hwaccel+=",vaapi"

	# Set rendering engine.
	use agg && renderers+=",agg"
	use cairo && renderers+=",cairo"
	use opengl && renderers+=",opengl"

	# Set kde and konqueror plugin directories.
	if use kde; then
		myconf="${myconf}
			--with-plugins-install=system
			--with-kde4-incl=${KDEDIR}/include
			--with-kde4-configdir=${KDEDIR}/share/config
			--with-kde4-prefix=${KDEDIR}
			--with-kde4-lib=${KDEDIR}/$(get_libdir)
			--with-kde-appsdatadir=${KDEDIR}/share/apps/klash
			--with-kde4-servicesdir=${KDEDIR}/share/kde4/services
			--with-kde4-plugindir=${KDEDIR}/$(get_libdir)/kde4/plugins"
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
		$(use_enable video_cards_intel i810-lod-bias) \
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
		pushd "${S}/plugin/klash4" >& /dev/null
		emake DESTDIR="${D}" install-plugin || die "install kde plugins failed"
		popd >& /dev/null
	fi
	# Create a symlink in /usr/$(get_libdir)/nsbrowser/plugins to the nsplugin install directory.
	use nsplugin && inst_plugin /usr/$(get_libdir)/gnash/npapi/libgnashplugin.so \

	# Remove pointless .la file, bug 338831
	if use python; then
		rm "${D}/$(python_get_sitedir)"/gtk-2.0/${PN}.la || die
	fi

	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
pkg_postinst() {
	if has_version net-misc/curl[threads]; then
		ewarn "net-misc/curl was built with USE=\"threads\", which causes problems."
		ewarn "If flash animations fail to download resources such as videos, build"
		ewarn "net-misc/curl without threading support. For details see"
		ewarn "https://bugs.gentoo.org/show_bug.cgi?id=332757 or"
		ewarn "https://savannah.gnu.org/bugs/?func=detailitem&item_id=30357"
	fi
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
