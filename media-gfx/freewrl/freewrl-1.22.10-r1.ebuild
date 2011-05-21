# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/freewrl/freewrl-1.22.10-r1.ebuild,v 1.3 2011/05/21 05:38:28 ssuominen Exp $

EAPI="2"

inherit nsplugins eutils flag-o-matic java-pkg-opt-2

DESCRIPTION="VRML2 and X3D compliant browser"
SRC_URI="mirror://sourceforge/freewrl/${P}.tar.bz2"
HOMEPAGE="http://freewrl.sourceforge.net/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl debug libeai +glew +java +motif +sox static-libs"

COMMONDEPEND="x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libX11
	motif? ( x11-libs/openmotif )
	media-libs/mesa
	glew? ( media-libs/glew )
	virtual/opengl
	media-libs/libpng
	virtual/jpeg
	media-libs/imlib2
	>=media-libs/freetype-2
	media-libs/fontconfig
	curl? ( net-misc/curl )
	>=dev-lang/spidermonkey-1.9"
DEPEND="${COMMONDEPEND}
	>=dev-util/pkgconfig-0.22
	java? ( >=virtual/jdk-1.4 )"
RDEPEND="${COMMONDEPEND}
	media-fonts/dejavu
	|| ( media-gfx/imagemagick
		media-gfx/graphicsmagick[imagemagick] )
	app-arch/unzip
	java? ( >=virtual/jre-1.4 )
	sox? ( media-sound/sox )"

src_prepare() {
	# A hack to get around expat being grabbed from xulrunner
	mkdir "${S}/src/lib/include";
	cp /usr/include/expat.h "${S}/src/lib/include/";
	cp /usr/include/expat_external.h "${S}/src/lib/include/";
}

src_configure() {
	local myconf="--enable-fontconfig --disable-plugin
		--with-imageconvert=/usr/bin/convert
		--with-unzip=/usr/bin/unzip"
	if use motif; then
		myconf="${myconf} --with-x --with-target=motif"
	else
		myconf="${myconf} --with-x --with-target=x11"
	fi
	if use sox; then
		myconf="${myconf} --with-soundconv=/usr/bin/sox"
	fi
	# disable the checks for other js libs, in case they are installed
	myconf="${myconf} --disable-mozilla-js --disable-xulrunner-js --disable-firefox-js --disable-seamonkey-js"
	# spidermonkey has no pkg-config, so override ./configure
	JAVASCRIPT_ENGINE_CFLAGS="-I/usr/include/js -DXP_UNIX"
	JAVASCRIPT_ENGINE_LIBS="-lmozjs"
	if has_version dev-lang/spidermonkey[threadsafe] ; then
		JAVASCRIPT_ENGINE_CFLAGS="${JAVASCRIPT_ENGINE_CFLAGS} -DJS_THREADSAFE $(pkg-config --cflags nspr)"
		JAVASCRIPT_ENGINE_LIBS="$(pkg-config --libs nspr) ${JAVASCRIPT_ENGINE_LIBS}"
	fi
	export JAVASCRIPT_ENGINE_CFLAGS
	export JAVASCRIPT_ENGINE_LIBS
	econf	${myconf} \
		$(use_enable curl libcurl) \
		$(use_with glew) \
		$(use_enable debug) $(use_enable debug thread_colorized) \
		$(use_enable libeai) \
		$(use_enable java) \
		$(use_enable static-libs static) \
		$(use_enable sox sound)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use java; then
		java-pkg_dojar src/java/vrml.jar
		insinto /usr/share/${PN}/lib
		doins src/java/java.policy
		elog "Because vrml.jar requires access to sockets, you will need to incorporate the"
		elog "contents of /usr/share/${PN}/lib/java.policy into your system or user's default"
		elog "java policy."
	fi

	# remove unneeded .la files (as per Flameeyes' rant)
	cd "${D}"
	rm "usr/$(get_libdir)"/*.la "usr/$(get_libdir)/${PLUGINS_DIR}"/*.la
}

pkg_postinst() {
	elog "All versions of FreeWRL are incompatible with xulrunner-2.0 and above."
	elog "This ebuild gets around it by removing support for browser plugins and forcing"
	elog "the javascript engine to spidermonkey.  If you are willing to downgrade to"
	elog "xulrunner-1.9 (as well as downgrade/rebuild all packages depending on it), then"
	elog "you can get this functionality back by adding =media-gfx/freewrl-1.22.10-r1 to your"
	elog "package.mask"
}
