# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/gnash/gnash-0.8.5.ebuild,v 1.15 2010/08/09 12:55:46 scarabeus Exp $

EAPI="2"
CMAKE_REQUIRED="never"
KDE_REQUIRED="optional"
AT_M4DIR="cygnal"

inherit autotools eutils kde4-base multilib nsplugins

DESCRIPTION="GNU Flash movie player that supports many SWF v7,8,9 features"
HOMEPAGE="http://www.gnu.org/software/gnash/"
SRC_URI="mirror://gnu/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="agg cairo cygnal doc +ffmpeg gnome gstreamer gtk kde +nls nsplugin +opengl +sdl +speex video_cards_intel +zlib"

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
	media-libs/libsdl[X]
	>=media-video/ffmpeg-0.5
	)
	gstreamer? (
	media-plugins/gst-plugins-ffmpeg
	media-plugins/gst-plugins-mad
	media-plugins/gst-plugins-meta
	)
	gtk? (
	x11-libs/gtk+:2
	net-libs/xulrunner:1.9
	)
	kde? ( >=kde-base/kdebase-startkde-${KDE_MINIMAL} )
	opengl? (
	virtual/opengl
	gtk? ( x11-libs/gtkglext )
	)
	sdl? ( media-libs/libsdl[X] )
	nsplugin? ( net-libs/xulrunner:1.9 )
	speex? ( media-libs/speex[ogg] )
	zlib? ( sys-libs/zlib )
	>=sys-devel/libtool-2.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	gnome? ( app-text/rarian )"

pkg_setup() {
	if ! ( use agg || use cairo || use opengl ); then
		ewarn "You are trying to build Gnash without choosing a renderer [agg|cairo|opengl]."
		has_version x11-libs/cairo && ewarn "cairo enabled as default" \
			|| die "Please enable a renderer"
	elif use agg && use cairo && use opengl; then
		ewarn "You enabled 3 renderers, agg was chosen as default."
	fi

	if use cairo && use !agg && use !opengl && use kde; then
		eerror "The cairo renderer and kde gui are not compatible."
		die "Cairo renderer incompatible with kde gui !"
	fi

	if ! ( use kde || use gtk || use sdl ); then
		ewarn "You are trying to build Gnash without choosing a gui frontend [gtk,kde,sdl]."
		has_version media-libs/libsdl[X] && ewarn "sdl enabled as default" \
			|| die "Please enable at least one of these USE flags."
	fi

	if use nsplugin && use !gtk; then
		eerror "Building gnash with nsplugin requires the gtk gui."
		die "Nsplugin requires the gtk gui."
	fi
	kde4-base_pkg_setup
}

src_prepare() {
	local mozsdk_incdir=${S}/plugin/mozilla-sdk/include

	# Defines $(XPIDL) correctly using sdkdir variable from libxul.pc
	epatch "${FILESDIR}"/${P}-xpidl-sdkdir.patch

	# Use pkgconfig to determine XPCOM_IDL_DIR instead of non-portable construct.
	# Fixes building against xulrunner-1.9.0, bug #284073.
	epatch "${FILESDIR}"/${P}-xpcom-idldir.patch

	# Resurect patch from bug #230287
	epatch "${FILESDIR}"/${PN}-0.8.3-boost-dynamic-link.patch

	# Adapted from Alt Linux to fix klash support properly
	epatch "${FILESDIR}"/${P}-klash.patch

	# Make gnash find moc and uic properly, upstream bug #25758,
	# gentoo bug #283905
	epatch "${FILESDIR}"/${P}-moc-qt4.patch

	epatch "${FILESDIR}"/${PN}-0.8.x-libpng14.patch

	# Conflict headers with npapi.h from mozilla-sdk embedded stuffs and libxul-unstable header
	# in case where xpcom (implicitly added with gtk) is enabled, we use the system header
	if use gtk; then
		rm -f ${mozsdk_incdir}/npapi.h
		ln -s $(pkg-config libxul-unstable --variable=includedir)/unstable/npapi.h \
			${mozsdk_incdir}/npapi.h || die "symlink failed"
	fi
	eautoreconf
}
src_configure() {
	local myconf
	local gui
	# Set nsplugin install directory.
	use nsplugin && myconf="${myconf} --with-npapi-plugindir=/opt/netscape/plugins"
	# Set kde and konqueror plugin directories.
	if use kde; then
		myconf="${myconf}
			--with-kde4-incl=${KDEDIR}/include
			--with-kde4-configdir=${KDEDIR}/share/config
			--with-kde4-prefix=${KDEDIR}
			--with-kde4-lib=${KDEDIR}/$(get_libdir)
			--with-kde-appsdatadir=${KDEDIR}/share/apps/klash
			--with-kde4-servicesdir=${KDEDIR}/share/services"
		 fi
	# Set rendering engine.
	if use agg; then
		myconf="${myconf} --enable-renderer=agg"
	elif use opengl; then
		myconf="${myconf} --enable-renderer=ogl"
	else
		myconf="${myconf} --enable-renderer=cairo"
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
	use sdl && gui="${gui},sdl"

	if [ -z "$gui" ]; then
		gui="sdl"
	fi
	# Strip extra comma from gui.
	gui=$( echo $gui|sed -e 's/,//' )
	econf \
		--disable-dependency-tracking \
		--disable-kparts3 \
		--enable-nspr \
		--enable-expat \
		--enable-jpeg \
		--enable-png \
		--enable-gif \
		--enable-ungif \
		$(use_enable cygnal) \
		$(use_enable doc docbook) \
		$(use_enable gnome ghelp) \
		$(use_enable gtk xpcom) \
		$(use_enable gtk npapi) \
		$(use_enable kde kparts4) \
		$(use_enable nls) \
		$(use_enable nsplugin npapi) \
		$(use_enable speex) \
		$(use_enable speex speexdsp) \
		$(use_enable video_cards_intel i810-lod-bias) \
		$(use_enable zlib z) \
		--enable-gui=${gui} \
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
	if use !ffmpeg && use !gstreamer || use gstreamer && ( ! use gnome ); then
		ewarn ""
		ewarn "Gnash was built without a media handler and or http handler !"
		ewarn ""
		ewarn "If you want Gnash to support video then you will need to"
		ewarn "rebuild Gnash with either the ffmpeg or gstreamer use flags set."
		ewarn ""
	fi
	ewarn "${PN} is still in heavy development"
	ewarn "Please first report bugs on upstream gnashdevs and deal with them"
	ewarn "And then report a Gentoo bug to the maintainer"
	use kde && kde4-base_pkg_postinst
}
