# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/kst/kst-2.0.0.ebuild,v 1.2 2012/05/21 19:55:15 ssuominen Exp $

EAPI=2

inherit eutils qt4-r2 multilib

MY_PN="${PN/k/K}"

DESCRIPTION="Fast real-time large-dataset viewing and plotting tool for KDE4"
HOMEPAGE="http://kst.kde.org/"
SRC_URI="mirror://sourceforge/project/${PN}/${MY_PN}%20${PV}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4[debug?]
	x11-libs/qt-opengl:4[debug?]
	x11-libs/qt-qt3support:4[debug?]
	x11-libs/qt-svg:4[debug?]
	x11-libs/qt-xmlpatterns:4[debug?]
	sci-libs/gsl
	sci-libs/cfitsio
	sci-libs/getdata"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-cfitsio-includes.patch" )

src_prepare() {
	qt4-r2_src_prepare
	sed -e "s:\(INSTALL_DIR/\)lib:\1$(get_libdir):" \
		-i src/libkst/libkst.pro src/libkstapp/libkstapp.pro \
		src/libkstmath/libkstmath.pro || die "sed libdir failed"

	sed -e "s:\(INSTALL_DIR/\)plugin:\1$(get_libdir)/kst/plugins:" \
		-i dataobjectplugin.pri datasourceplugin.pri src/widgets/widgets.pro \
		|| die "sed plugins install path failed"

	sed -e "s!QLibraryInfo::location(QLibraryInfo::PluginsPath)!\"/usr/$(get_libdir)/kst/plugins\"!" \
		-i src/libkst/datasource.cpp src/libkstmath/dataobject.cpp \
		|| die "sed plugins search path failed"

	# libkstwidgets is a Qt Designer plugin but they link against it (!!!)
	# so either we keep it in plugins dir and set the rpath, or move to
	# lib dir and add a SONAME. Currently the first solution is in use.
	sed -e "s!\(QMAKE_RPATHDIR += \).*!\1/usr/$(get_libdir)/kst/plugins!" \
		-i kst.pri src/d2asc/d2asc.pro src/d2d/d2d.pro \
		|| die "sed rpath failed"
}

src_configure() {
	export INSTALL_LIBDIR="$(get_libdir)"
	eqmake4
}

src_install() {
	qt4-r2_src_install
	doicon src/images/${PN}.png
	make_desktop_entry "${PN}2" ${PN} ${PN} \
		"Qt;Graphics;DataVisualization" || die "make_desktop_entry failed"
	dodoc AUTHORS ChangeLog NEWS README RELEASE.NOTES || die "dodoc failed"
}
