# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/plasma/plasma-4.0.4.ebuild,v 1.1 2008/05/16 00:55:19 ingmar Exp $

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
PDEPEND="
	kde-base/kdeartwork-iconthemes:${SLOT}"

KMEXTRACTONLY="krunner/org.freedesktop.ScreenSaver.xml
	krunner/org.kde.krunner.Interface.xml
	ksmserver/org.kde.KSMServerInterface.xml
	libs/taskmanager/
	libs/plasma/"
KMLOADLIBS="libplasma"

PATCHES="${FILESDIR}/${PN}-4.0.3-kickoff.patch"

KDE4_BUILT_WITH_USE_CHECK="app-misc/strigi dbus qt4"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with xcomposite X11_Xcomposite)
		$(cmake-utils_use_with xinerama X11_Xinerama)"

	kde4-meta_src_compile
}
