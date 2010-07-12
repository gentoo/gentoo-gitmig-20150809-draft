# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/gnash/gnash-0.8.7_p20100706.ebuild,v 1.1 2010/07/12 14:45:21 chithanh Exp $

EAPI=3
CMAKE_REQUIRED="never"
KDE_REQUIRED="optional"
KDE_MINIMAL="4.2"
AT_M4DIR="cygnal"

inherit autotools eutils kde4-base multilib nsplugins flag-o-matic

DESCRIPTION="GNU Flash movie player that supports many SWF v7,8,9 features"
HOMEPAGE="http://www.gnu.org/software/gnash/"
SRC_URI="mirror://gentoo//${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="+agg cairo cygnal dbus doc +ffmpeg gnome gstreamer gtk kde lirc mysql +nls nsplugin opengl python +sdl ssh ssl test vaapi video_cards_intel xv"

RDEPEND=">=dev-libs/boost-1.35.0
	dev-libs/expat
	dev-libs/libxml2
	media-libs/jpeg
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
	media-libs/libsdl[X]
	media-libs/speex[ogg]
	sys-libs/zlib
	>=sys-devel/libtool-2.2
	mysql? ( dev-db/mysql )
	lirc? ( app-misc/lirc )
	dbus? ( sys-apps/dbus )
	ssh?  ( >=net-libs/libssh-0.4[server] )
	ssl?  ( dev-libs/openssl )
	vaapi? ( x11-libs/libva[opengl?] )
	xv? ( x11-libs/libXv ) "
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	gnome? ( app-text/rarian )"

pkg_setup() {
	if use vaapi && use !ffmpeg; then
		eerror "Support for VAAPI currently requires the ffmpeg media handler."
		die "vaapi requires the ffmpeg USE flag."
	fi

	if ! ( use agg || use cairo || use opengl ); then
		eerror "You are trying to build Gnash without choosing a renderer [agg|cairo|opengl]."
		die "Please enable a renderer"
	fi

	if ! ( use kde || use gtk || use sdl ); then
		ewarn "You are trying to build Gnash without choosing a gui frontend [gtk,kde,sdl]."
		ewarn "sdl enabled as default"
#		die "Please enable at least one of these USE flags."
	fi

	if use python && use !gtk; then
		eerror "Building gnash with python support requires gtk."
		die "python requires the gtk USE flag."
	fi

	if use nsplugin && use !gtk; then
		eerror "Building gnash with nsplugin requires the gtk gui."
		die "Nsplugin requires the gtk gui."
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

	# Defines $(XPIDL) correctly using sdkdir variable from libxul.pc
	epatch "${FILESDIR}"/${PN}-0.8.5-xpidl-sdkdir.patch

	# Use pkgconfig to determine XPCOM_IDL_DIR instead of non-portable construct.
	# Fixes building against xulrunner-1.9.0, bug #284073.
	epatch "${FILESDIR}"/${PN}-0.8.7-xpcom-idldir.patch

	# Resurect patch from bug #230287
	epatch "${FILESDIR}"/${PN}-0.8.3-boost-dynamic-link.patch

	# Adapted from Alt Linux to fix klash support properly
	epatch "${FILESDIR}"/${PN}-0.8.8-klash.patch

	# Make gnash find moc and uic properly, upstream bug #25758,
	# gentoo bug #283905
	epatch "${FILESDIR}"/${PN}-0.8.7-moc-qt4.patch

	eautoreconf
}
src_configure() {
	append-flags -D__STDC_CONSTANT_MACROS #324357

	local gui hwaccel myconf myext renderers

	# Set nsplugin install directory.
	use nsplugin && myconf="${myconf} --with-npapi-plugindir=/opt/netscape/plugins"

	# Set hardware acceleration
	use xv && hwaccel+=",xv"
	use vaapi && hwaccel+=",vaapi"
	use xv || use vaapi || hwaccel="none"

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
	if use ffmpeg; then
		myconf="${myconf} --enable-media=ffmpeg"
	elif use gstreamer; then
		myconf="${myconf} --enable-media=gst"
	else
		myconf="${myconf} --enable-media=none"
	fi
	# Set gui.
	use gtk && gui=",gtk"
	use kde && gui="${gui},kde4"

	if use sdl; then
		gui="${gui},sdl"
		myconf="${myconf} --enable-sound=sdl"
	fi

	# Set extensions
	use mysql && myext=",mysql"
	use gtk && myext="${myext},gtk"
	use lirc && myext="${myext},lirc"
	use dbus && myext="${myext},dbus"

	if [ -z "$gui" ]; then
		gui="sdl"
	fi

	# Strip extra comma from gui, myext, hwaccel and renderers.
	gui=$( echo $gui | sed -e 's/,//' )
	hwaccel=$( echo $hwaccel | sed -e 's/,//' )
	myext=$( echo $myext | sed -e 's/,//' )
	renderers=$( echo $renderers | sed -e 's/,//' )

	econf \
		--docdir=/usr/share/doc/${PF} \
		--disable-dependency-tracking \
		--disable-kparts3 \
		--enable-avm2 \
		$(use_enable cygnal) \
		$(use_enable cygnal cgibins) \
		$(use_enable doc docbook) \
		$(use_enable gnome ghelp) \
		$(use_enable gtk npapi) \
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
	use nsplugin && inst_plugin /opt/netscape/plugins/libgnashplugin.so \
		|| rm -rf "${D}/opt"
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
