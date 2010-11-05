# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-webkit/qt-webkit-4.5.3-r1.ebuild,v 1.5 2010/11/05 18:05:45 jer Exp $

EAPI="2"
inherit eutils qt4-build flag-o-matic

DESCRIPTION="The Webkit module for the Qt toolkit"
SLOT="4"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kde"

DEPEND="~x11-libs/qt-core-${PV}[debug=,ssl]
	~x11-libs/qt-dbus-${PV}[debug=]
	~x11-libs/qt-gui-${PV}[dbus,debug=]
	!kde? ( || ( ~x11-libs/qt-phonon-${PV}:${SLOT}[dbus,debug=]
		media-sound/phonon ) )
	kde? ( media-sound/phonon )"
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
	epatch "${FILESDIR}"/30_webkit_unaligned_access.diff #235685
	qt4-build_src_prepare
}

src_configure() {
	# This fixes relocation overflows on alpha
	use alpha && append-ldflags "-Wl,--no-relax"
	myconf="${myconf} -webkit"
	qt4-build_src_configure
}
