# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/qvfb/qvfb-4.6.3.ebuild,v 1.4 2012/04/02 20:33:44 pacho Exp $

EAPI="2"
inherit qt4-build

DESCRIPTION="The Qt Embedded Virtual Framebuffer emulator."
HOMEPAGE="http://www.trolltech.com/"
SLOT="4"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND="~x11-libs/qt-gui-${PV}"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="tools/qvfb"
QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}
	include/Qt/
	include/QtCore/
	include/QtGui/
	src/corelib/
	src/gui/
	tools/shared/"

src_configure() {
	myconf="${myconf} -no-xkb -no-fontconfig -no-xrender -no-xrandr
		-no-xfixes -no-xcursor -no-xinerama -no-xshape -no-sm -no-opengl
		-no-nas-sound -no-dbus -iconv -no-cups -no-nis -no-gif -no-libpng
		-no-libmng -no-libjpeg -no-openssl -system-zlib -no-webkit -no-phonon
		-no-xmlpatterns -no-freetype -no-libtiff  -no-accessibility
		-no-glib -no-qt3support -no-svg"

	qt4-build_src_configure
}
