# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/freewrl/freewrl-1.22.9.ebuild,v 1.3 2010/10/10 18:38:12 ulm Exp $

EAPI="2"

inherit nsplugins eutils flag-o-matic

DESCRIPTION="VRML2 and X3D compliant browser"
SRC_URI="mirror://sourceforge/freewrl/${P}.tar.bz2"
HOMEPAGE="http://freewrl.sourceforge.net/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl debug libeai +glew +motif nsplugin +sox spidermonkey static"

COMMONDEPEND="x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libX11
	motif? ( >=x11-libs/openmotif-2.3:0 )
	media-libs/mesa
	glew? ( media-libs/glew )
	virtual/opengl
	media-libs/libpng
	media-libs/jpeg
	media-libs/imlib2
	>=media-libs/freetype-2
	curl? ( net-misc/curl )
	!spidermonkey? ( net-libs/xulrunner )
	spidermonkey? ( dev-lang/spidermonkey )
	nsplugin? ( || (
		net-libs/xulrunner
		www-client/firefox
		) )"
DEPEND="${COMMONDEPEND}
	>=dev-util/pkgconfig-0.22"
RDEPEND="${COMMONDEPEND}
	media-fonts/ttf-bitstream-vera
	media-gfx/imagemagick
	app-arch/unzip
	sox? ( media-sound/sox )"

src_prepare() {
	# A hack to get around expat being grabbed from xulrunner
	mkdir "${S}/src/lib/include";
	cp /usr/include/expat.h "${S}/src/lib/include/";
	cp /usr/include/expat_external.h "${S}/src/lib/include/";
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
	if use spidermonkey; then
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
		# more hack to get around expat being grabbed from xulrunner
		myconf="${myconf} --with-expat=${S}/src/lib"
	fi
	econf	${myconf} \
		$(use_enable curl libcurl) \
		$(use_with glew) \
		$(use_enable debug) $(use_enable debug thread_colorized) \
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
