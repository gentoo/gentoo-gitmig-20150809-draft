# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/freewrl/freewrl-1.22.6-r1.ebuild,v 1.3 2010/07/25 19:17:49 nirbheek Exp $

EAPI="2"

inherit nsplugins eutils flag-o-matic autotools

DESCRIPTION="VRML2 and X3D compliant browser"
SRC_URI="mirror://sourceforge/freewrl/${P}.tar.bz2"
HOMEPAGE="http://freewrl.sourceforge.net/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl debug libeai +motif nsplugin +sox spidermonkey static +xulrunner"

COMMONDEPEND="x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libX11
	motif? ( x11-libs/openmotif )
	media-libs/mesa
	media-libs/glew
	virtual/opengl
	media-libs/libpng
	media-libs/jpeg
	media-libs/imlib2
	>=media-libs/freetype-2
	curl? ( net-misc/curl )
	xulrunner? ( net-libs/xulrunner )
	!xulrunner? (
		spidermonkey? ( dev-lang/spidermonkey )
		!spidermonkey? ( || (
			=www-client/firefox-3*[-xulrunner]
			=www-client/firefox-2*
		) )
	)
	nsplugin? ( || ( xulrunner? ( net-libs/xulrunner )
		>=www-client/firefox-2.0 ) )"
DEPEND="${COMMONDEPEND}
	>=dev-util/pkgconfig-0.22"
RDEPEND="${COMMONDEPEND}
	media-fonts/ttf-bitstream-vera
	media-gfx/imagemagick
	app-arch/unzip
	sox? ( media-sound/sox )"

pkg_setup() {
	if use xulrunner && use spidermonkey; then
		eerror "Please choose only one of xulrunner or spidermonkey."
		die "Cannot USE both spidermonkey and xulrunner"
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng14.patch

	# A hack to get around expat being grabbed from xulrunner
	if use xulrunner && has_version ">=net-libs/xulrunner-1.9.2"; then
		mkdir "${S}/src/lib/include";
		cp /usr/include/expat.h "${S}/src/lib/include/";
		cp /usr/include/expat_external.h "${S}/src/lib/include/";
		epatch "${FILESDIR}/${P}-xulrunner192-fixes.patch";
		eautoreconf
	fi
}

src_configure() {
	local myconf="--with-fontsdir=/usr/share/fonts/ttf-bitstream-vera
		--with-imageconvert=/usr/bin/convert
		--with-unzip=/usr/bin/unzip"
	if use motif; then
		myconf="${myconf} --with-x --with-target=motif"
	else
		myconf="${myconf} --with-x --with-target=x11"
	fi
	if use nsplugin; then
		myconf="${myconf} --with-plugindir=/usr/$(get_libdir)/${PLUGINS_DIR}"
	fi
	if use sox; then
		myconf="${myconf} --with-soundconv=/usr/bin/sox"
	fi
	if use xulrunner; then
		if has_version net-libs/xulrunner:1.9 ; then
			if has_version ">=net-libs/xulrunner-1.9.2"; then
				# more hack to get around expat being grabbed from xulrunner
				myconf="${myconf} --with-expat=${S}/src/lib"
			else
				# fix missing library path to xulrunner-1.9 libraries
				append-ldflags "-R/usr/$(get_libdir)/xulrunner-1.9/lib"
			fi
		fi
	elif use spidermonkey; then
		# disable the checks for other js libs, in case they are installed
		myconf="${myconf} --disable-mozilla-js --disable-xulrunner-js --disable-firefox-js --disable-seamonkey-js"
		# spidermonkey has no pkg-config, so override ./configure
		JAVASCRIPT_ENGINE_CFLAGS="-I/usr/include/js -DXP_UNIX"
		JAVASCRIPT_ENGINE_LIBS="-ljs"
		if has_version dev-lang/spidermonkey[threadsafe] ; then
			JAVASCRIPT_ENGINE_CFLAGS="${JAVASCRIPT_ENGINE_CFLAGS} -DJS_THREADSAFE $(pkg-config --cflags nspr)"
			JAVASCRIPT_ENGINE_LIBS="$(pkg-config --libs nspr) ${JAVASCRIPT_ENGINE_LIBS}"
		fi
		export JAVASCRIPT_ENGINE_CFLAGS
		export JAVASCRIPT_ENGINE_LIBS
	else
		# disable checks for xulrunner libs, in case they are installed
		myconf="${myconf} --disable-mozilla-js --disable-xulrunner-js"
		# not using xulrunner, so ./configure grabs js directly from firefox/mozilla/thunderbird/wherever
		if has_version =www-client/firefox-3* ; then
			# override ./configure for firefox-3 as pkg-config doesn't detect the right settings
			export MOZILLA_PLUGIN_CFLAGS="-I/usr/include/mozilla-firefox/stable $(pkg-config --cflags nspr)"
			export MOZILLA_PLUGIN_LIBS=" "
			export JAVASCRIPT_ENGINE_CFLAGS="-DXP_UNIX -DJS_THREADSAFE -DMOZILLA_JS_UNSTABLE_INCLUDES ${MOZILLA_PLUGIN_CFLAGS}"
			export JAVASCRIPT_ENGINE_LIBS="$(pkg-config --libs nspr) -L/usr/$(get_libdir)/mozilla-firefox -lmozjs"
			append-ldflags "-R/usr/$(get_libdir)/mozilla-firefox"
		fi
	fi
	econf	${myconf} \
		$(use_enable curl libcurl) \
		$(use_enable debug) \
		$(use_enable libeai) \
		$(use_enable nsplugin plugin) \
		$(use_enable static) \
		$(use_enable sox sound)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# remove unneeded .la files (as per Flameeyes' rant)
	cd "${D}"
	rm "usr/$(get_libdir)"/*.la "usr/$(get_libdir)/${PLUGINS_DIR}"/*.la
}
