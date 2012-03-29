# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-openvg/qt-openvg-4.8.1.ebuild,v 1.1 2012/03/29 22:13:37 pesa Exp $

EAPI=4

inherit qt4-build

DESCRIPTION="The OpenVG module for the Qt toolkit"
SLOT="4"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="qt3support"

DEPEND="
	media-libs/mesa[egl,openvg]
	~x11-libs/qt-core-${PV}[aqua=,c++0x=,debug=,qpa=,qt3support=]
	~x11-libs/qt-gui-${PV}[aqua=,c++0x=,debug=,egl,qpa=,qt3support=]
"
RDEPEND="${DEPEND}"

pkg_setup() {
	QT4_TARGET_DIRECTORIES="
		src/openvg
		src/plugins/graphicssystems/openvg"

	QT4_EXTRACT_DIRECTORIES="
		include/QtCore
		include/QtGui
		include/QtOpenVG
		src/corelib
		src/gui
		src/openvg
		src/plugins
		src/3rdparty"

	QCONFIG_ADD="openvg"
	QCONFIG_DEFINE="QT_OPENVG"

	qt4-build_pkg_setup
}

src_configure() {
	gltype="desktop"

	myconf+="
		-openvg -egl
		$(qt_use qt3support)"

	qt4-build_src_configure
}

src_install() {
	qt4-build_src_install

	# touch the available graphics systems
	dodir /usr/share/qt4/graphicssystems
	echo "experimental" > "${ED}"/usr/share/qt4/graphicssystems/openvg || die
}
