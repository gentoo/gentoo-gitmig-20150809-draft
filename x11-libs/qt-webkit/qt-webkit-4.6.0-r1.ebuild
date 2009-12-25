# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-webkit/qt-webkit-4.6.0-r1.ebuild,v 1.1 2009/12/25 15:46:59 abcd Exp $

EAPI="2"
inherit qt4-build

DESCRIPTION="The Webkit module for the Qt toolkit"
SLOT="4"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 -sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="kde"

DEPEND="~x11-libs/qt-core-${PV}[aqua=,debug=,ssl]
	~x11-libs/qt-dbus-${PV}[aqua=,debug=]
	~x11-libs/qt-gui-${PV}[aqua=,dbus,debug=]
	~x11-libs/qt-xmlpatterns-${PV}[aqua=,debug=]
	!kde? ( || ( ~x11-libs/qt-phonon-${PV}:${SLOT}[aqua=,dbus,debug=]
		media-sound/phonon[aqua=] ) )
	kde? ( media-sound/phonon[aqua=] )"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="src/3rdparty/webkit/WebCore tools/designer/src/plugins/qwebview"
QT4_EXTRACT_DIRECTORIES="
include/
src/
tools/"
QCONFIG_ADD="webkit"
QCONFIG_DEFINE="QT_WEBKIT"

src_prepare() {
	[[ $(tc-arch) == "ppc64" ]] && append-flags -mminimal-toc #241900
	if use sparc; then
		epatch "${FILESDIR}"/sparc-qt-webkit-sigbus.patch
	fi
	epatch "${FILESDIR}"/${P}-solaris-jsvalue.patch
	epatch "${FILESDIR}"/${P}-solaris-strnstr.patch
	qt4-build_src_prepare
}

src_configure() {
	myconf="${myconf} -webkit"
	qt4-build_src_configure
}
