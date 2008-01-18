# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libplasma/libplasma-4.0.0.ebuild,v 1.1 2008/01/18 01:37:40 ingmar Exp $

EAPI="1"

KMNAME=kdebase-workspace
KMMODULE="libs/plasma"
inherit kde4-meta

DESCRIPTION="Plasma: KDE desktop framework"
KEYWORDS="~amd64 ~x86"
IUSE="debug opengl test xinerama"
RESTRICT="test"

COMMONDEPEND="
	!<kde-base/plasma-3.96.0
	>=kde-base/libkworkspace-${PV}:${SLOT}
	>=kde-base/libtaskmanager-${PV}:${SLOT}
	x11-libs/libXau
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	opengl? ( virtual/opengl )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${COMMONDEPEND}
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="${COMMONDEPEND}"

KMEXTRACTONLY="
	ksmserver/org.kde.KSMServerInterface.xml
	krunner/org.freedesktop.ScreenSaver.xml
	krunner/org.kde.krunner.Interface.xml
	libs/workspace/
	libs/taskmanager/"

KDE4_BUILT_WITH_USE_CHECK="-a app-misc/strigi dbus qt4"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xinerama X11_Xinerama)"

	kde4-meta_src_compile
}

src_install() {
	kde4-meta_src_install

	# Outsmart our doc-handling, to avoid a collision with plasma.
	rm -rf "${D}"/${PREFIX}/share/doc/
}

src_test() {
	sed -e "s/packagestructuretest//" \
		-i "${S}/"libs/plasma/tests/CMakeLists.txt
	kde4-meta_src_test
}
