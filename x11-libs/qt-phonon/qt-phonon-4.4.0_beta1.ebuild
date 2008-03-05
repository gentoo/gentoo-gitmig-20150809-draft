# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-phonon/qt-phonon-4.4.0_beta1.ebuild,v 1.1 2008/03/05 23:12:52 ingmar Exp $

inherit qt4-build

DESCRIPTION="The Phonon module for the Qt toolkit."
HOMEPAGE="http://www.trolltech.com/"

LICENSE="|| ( QPL-1.0 GPL-3 GPL-2 )"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="dbus"

DEPEND="~x11-libs/qt-gui-${PV}
	media-libs/gstreamer
	media-libs/gst-plugins-base
	dbus? ( =x11-libs/qt-dbus-${PV} )"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="
src/phonon
src/plugins/phonon"
QCONFIG_ADD="phonon"
QCONFIG_DEFINE="QT_GSTREAMER"

src_compile() {
	local myconf
	myconf="${myconf} -phonon -no-opengl
		$(qt_use dbus qdbus)"

	qt4-build_src_compile
}
