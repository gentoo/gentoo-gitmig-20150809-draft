# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/plasma/plasma-4.0.0.ebuild,v 1.2 2008/01/18 03:08:18 mr_bones_ Exp $

EAPI="1"

KMNAME=kdebase-workspace
inherit kde4-meta

DESCRIPTION="Plasma: KDE desktop framework"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook xcomposite xinerama"

COMMONDEPEND="
	>=app-misc/strigi-0.5.7
	>=kde-base/libkworkspace-${PV}:${SLOT}
	>=kde-base/libtaskmanager-${PV}:${SLOT}
	>=kde-base/libplasma-${PV}:${SLOT}
	x11-libs/libXau
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	xcomposite? ( x11-libs/libXcomposite )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${COMMONDEPEND}
	xcomposite? ( x11-proto/compositeproto )
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="${COMMONDEPEND}
	>=kde-base/kde-menu-icons-${PV}:${SLOT}"

KMEXTRACTONLY="
	ksmserver/org.kde.KSMServerInterface.xml
	krunner/org.freedesktop.ScreenSaver.xml
	krunner/org.kde.krunner.Interface.xml
	libs/workspace/
	libs/taskmanager/"

PATCHES="${FILESDIR}/${P}-linkage.patch"

KDE4_BUILT_WITH_USE_CHECK="app-misc/strigi dbus qt4"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with xcomposite X11_Xcomposite)
		$(cmake-utils_use_with xinerama X11_Xinerama)"
	kde4-meta_src_compile
}
