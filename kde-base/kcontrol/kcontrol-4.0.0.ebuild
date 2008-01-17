# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-4.0.0.ebuild,v 1.1 2008/01/17 23:37:45 philantrop Exp $

EAPI="1"

KMNAME=kdebase-runtime
inherit kde4-meta

DESCRIPTION="The KDE Control Center"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook ieee1394 logitech-mouse opengl ssl"

DEPEND="
	>=media-libs/freetype-2
	media-libs/fontconfig
	ieee1394? ( sys-libs/libraw1394 )
	logitech-mouse? ( >=dev-libs/libusb-0.1.10a )
	opengl? ( virtual/opengl )
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}
	sys-apps/usbutils
	>=kde-base/kcminit-${PV}:${SLOT}
	>=kde-base/kdebase-data-${PV}:${SLOT}
	>=kde-base/kdesu-${PV}:${SLOT}
	>=kde-base/khelpcenter-${PV}:${SLOT}
	>=kde-base/khotkeys-${PV}:${SLOT}
	>=kde-base/libkonq-${PV}:${SLOT}
	>=kde-base/systemsettings-${PV}:${SLOT}"

KMEXTRACTONLY="
	kwin/
	klipper/
	krunner/
	libs/kworkspace/
	plasma/plasma/org.kde.plasma.App.xml"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWITH_LibXKlavier=ON -DWITH_GLIB2=ON -DWITH_GObject=ON
		$(cmake-utils_use_with ieee1394 RAW1394)
		$(cmake-utils_use_with logitech-mouse USB)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with ssl OpenSSL)"
	kde4-meta_src_compile
}
