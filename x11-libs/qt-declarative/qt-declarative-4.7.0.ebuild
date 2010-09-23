# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-declarative/qt-declarative-4.7.0.ebuild,v 1.2 2010/09/23 21:36:25 wired Exp $

EAPI="3"
inherit qt4-build

DESCRIPTION="The Declarative module for the Qt toolkit"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="private-headers"

DEPEND="~x11-libs/qt-core-${PV}[aqua=]
	~x11-libs/qt-gui-${PV}[aqua=]
	~x11-libs/qt-multimedia-${PV}[aqua=]
	~x11-libs/qt-opengl-${PV}[aqua=]
	~x11-libs/qt-script-${PV}[aqua=]
	~x11-libs/qt-sql-${PV}[aqua=]
	~x11-libs/qt-svg-${PV}[aqua=]
	~x11-libs/qt-webkit-${PV}[aqua=]
	~x11-libs/qt-xmlpatterns-${PV}[aqua=]"
RDEPEND="${DEPEND}"

pkg_setup() {
	QCONFIG_ADD="declarative"

	QT4_TARGET_DIRECTORIES="
		src/declarative
		tools/qml"
	QT4_EXTRACT_DIRECTORIES="
		include/
		src/
		tools/"

	qt4-build_pkg_setup
}

src_configure() {
	myconf="${myconf} -declarative"
	qt4-build_src_configure
}

src_install() {
	qt4-build_src_install
	if use private-headers; then
		insinto ${QTHEADERDIR}/QtDeclarative/private
		find "${S}"/src/declarative/ -type f -name "*_p.h" -exec doins {} \;
	fi
}
