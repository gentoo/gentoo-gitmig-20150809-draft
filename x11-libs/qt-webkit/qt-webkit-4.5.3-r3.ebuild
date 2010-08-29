# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-webkit/qt-webkit-4.5.3-r3.ebuild,v 1.7 2010/08/29 17:50:02 armin76 Exp $

EAPI="2"
inherit eutils qt4-build flag-o-matic

DESCRIPTION="The Webkit module for the Qt toolkit"
SLOT="4"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="dbus kde"

DEPEND="~x11-libs/qt-core-${PV}[debug=,ssl]
	~x11-libs/qt-gui-${PV}[dbus?,debug=]
	dbus? ( ~x11-libs/qt-dbus-${PV}[debug=] )
	!kde? ( || ( ~x11-libs/qt-phonon-${PV}:${SLOT}[dbus=,debug=]
		media-sound/phonon ) )
	kde? ( media-sound/phonon )"
RDEPEND="${DEPEND}"

pkg_setup() {
	QT4_TARGET_DIRECTORIES="
		src/3rdparty/webkit/WebCore
		tools/designer/src/plugins/qwebview"
	QT4_EXTRACT_DIRECTORIES="
		include/
		src/
		tools/"
	QCONFIG_ADD="webkit"
	QCONFIG_DEFINE="QT_WEBKIT"

	qt4-build_pkg_setup
}

src_prepare() {
	[[ $(tc-arch) == "ppc64" ]] && append-flags -mminimal-toc #241900
	epatch "${FILESDIR}"/30_webkit_unaligned_access.diff #235685
	epatch "${FILESDIR}"/${P}-no-javascript-crash.patch #295573

	# patches graciously borrowed from Fedora for bug #314193
	epatch "${FILESDIR}"/${P}-cve-2010-0046-css-format-mem-corruption.patch
	epatch "${FILESDIR}"/${P}-cve-2010-0049-freed-line-boxes-ltr-rtl.patch
	epatch "${FILESDIR}"/${P}-cve-2010-0050-crash-misnested-style-tags.patch
	epatch "${FILESDIR}"/${P}-cve-2010-0052-destroyed-input-cached.patch

	qt4-build_src_prepare
}

src_configure() {
	# This fixes relocation overflows on alpha
	use alpha && append-ldflags "-Wl,--no-relax"
	myconf="${myconf} -webkit $(qt_use dbus qdbus)"
	qt4-build_src_configure
}
