# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-phonon/qt-phonon-4.7.0.ebuild,v 1.1 2010/09/21 14:57:13 tampakrap Exp $

EAPI="2"
inherit qt4-build

DESCRIPTION="The Phonon module for the Qt toolkit"
SLOT="4"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="dbus"

DEPEND="~x11-libs/qt-gui-${PV}[debug=,glib,qt3support]
	!kde-base/phonon-kde
	!kde-base/phonon-xine
	!media-sound/phonon
	media-libs/gstreamer
	media-plugins/gst-plugins-meta
	dbus? ( ~x11-libs/qt-dbus-${PV}[debug=] )"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="
	src/phonon
	src/plugins/phonon
	tools/designer/src/plugins/phononwidgets"
QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}
	include/
	src
	tools"

QCONFIG_ADD="phonon"
QCONFIG_DEFINE="QT_GSTREAMER"

src_configure() {
	myconf="${myconf} -phonon -phonon-backend -no-opengl -no-svg
		$(qt_use dbus qdbus)"

	qt4-build_src_configure
}
