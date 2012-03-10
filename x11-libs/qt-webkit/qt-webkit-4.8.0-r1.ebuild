# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-webkit/qt-webkit-4.8.0-r1.ebuild,v 1.5 2012/03/10 16:05:31 pesa Exp $

EAPI="3"
inherit qt4-build flag-o-matic

DESCRIPTION="The WebKit module for the Qt toolkit"
SLOT="4"
KEYWORDS="~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 -sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="+gstreamer +jit"

DEPEND="
	dev-db/sqlite:3
	dev-libs/icu
	x11-libs/libXrender
	~x11-libs/qt-core-${PV}[aqua=,c++0x=,qpa=,debug=,ssl]
	~x11-libs/qt-gui-${PV}[aqua=,c++0x=,qpa=,debug=]
	~x11-libs/qt-xmlpatterns-${PV}[aqua=,c++0x=,qpa=,debug=]
	gstreamer? (
		dev-libs/glib:2
		media-libs/gstreamer:0.10
		media-libs/gst-plugins-base:0.10
	)"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-c++0x-fix.patch"
)

pkg_setup() {
	QT4_TARGET_DIRECTORIES="
		src/3rdparty/webkit/Source/JavaScriptCore
		src/3rdparty/webkit/Source/WebCore
		src/3rdparty/webkit/Source/WebKit/qt
		tools/designer/src/plugins/qwebview"

	QT4_EXTRACT_DIRECTORIES="
		include
		src
		tools"

	QCONFIG_ADD="webkit"
	QCONFIG_DEFINE="QT_WEBKIT"

	qt4-build_pkg_setup
}

src_prepare() {
	use c++0x && append-cxxflags -fpermissive

	# Fix version number in generated pkgconfig file, bug 406443
	sed -i -e 's/^isEmpty(QT_BUILD_TREE)://' \
		src/3rdparty/webkit/Source/WebKit/qt/QtWebKit.pro || die

	# Always enable icu to avoid build failure, bug 407315
	sed -i -e '/CONFIG\s*+=\s*text_breaking_with_icu/ s:^#\s*::' \
		src/3rdparty/webkit/Source/JavaScriptCore/JavaScriptCore.pri || die

	sed -i -e '/QMAKE_CXXFLAGS\s*+=/ s:-Werror::g' \
		src/3rdparty/webkit/Source/WebKit.pri || die

	qt4-build_src_prepare
}

src_configure() {
	myconf+="
		-webkit
		-icu -system-sqlite
		$(qt_use jit javascript-jit)
		$(use gstreamer || echo -DENABLE_VIDEO=0)
	"
	qt4-build_src_configure
}
