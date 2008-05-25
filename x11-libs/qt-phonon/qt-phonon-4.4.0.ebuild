# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-phonon/qt-phonon-4.4.0.ebuild,v 1.2 2008/05/25 08:34:43 corsair Exp $

inherit qt4-build

DESCRIPTION="The Phonon module for the Qt toolkit."
HOMEPAGE="http://www.trolltech.com/"

LICENSE="|| ( QPL-1.0 GPL-3 GPL-2 )"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="dbus"

DEPEND="~x11-libs/qt-gui-${PV}
	media-libs/gstreamer
	media-libs/gst-plugins-base
	dbus? ( =x11-libs/qt-dbus-${PV} )"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="
src/phonon
src/plugins/phonon"
QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}
src/3rdparty/kdelibs/phonon/
src/3rdparty/kdebase/runtime/phonon/"
QCONFIG_ADD="phonon"
QCONFIG_DEFINE="QT_GSTREAMER"

src_compile() {
	local myconf
	myconf="${myconf} -phonon -no-opengl -no-svg
		$(qt_use dbus qdbus)"

	qt4-build_src_compile
}
