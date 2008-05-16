# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libplasma/libplasma-4.0.4.ebuild,v 1.1 2008/05/16 00:48:57 ingmar Exp $

EAPI="1"

KMNAME=kdebase-workspace
KMMODULE="libs/plasma"
CPPUNIT_REQUIRED="optional"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Plasma: KDE desktop framework"
KEYWORDS="~amd64 ~x86"
IUSE="debug opengl test xinerama"

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

KMEXTRACTONLY="krunner/org.freedesktop.ScreenSaver.xml
	krunner/org.kde.krunner.Interface.xml
	ksmserver/org.kde.KSMServerInterface.xml
	libs/taskmanager/"
KMSAVELIBS="true"

KDE4_BUILT_WITH_USE_CHECK="app-misc/strigi dbus qt4"

# Disabling tests for now. 3 out of 3 broken now. last tested on 4.0.1.
RESTRICT="test"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xinerama X11_Xinerama)"

	kde4-meta_src_compile
}

src_install() {
	kde4-meta_src_install

	# Outsmart our doc-handling, to avoid a collision with plasma.
	rm -rf "${D}"/${KDEDIR}/share/doc/
}
