# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-dbus/qt-dbus-4.4.0.ebuild,v 1.1 2008/05/15 12:44:36 ingmar Exp $

inherit qt4-build

DESCRIPTION="The DBus module for the Qt toolkit."
HOMEPAGE="http://www.trolltech.com/"

LICENSE="|| ( QPL-1.0 GPL-3 GPL-2 )"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

# depend on gui instead of core.  There's a GUI based viewer that's built, and since it's a desktop
# protocol I don't know if there's value trying to derive it out into a core build
# The library itself, however, only depends on core and xml
DEPEND="~x11-libs/qt-core-${PV}
	>=sys-apps/dbus-1.0.2"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="
src/dbus
tools/qdbus/qdbus
tools/qdbus/qdbusxml2cpp
tools/qdbus/qdbuscpp2xml"
QCONFIG_ADD="dbus dbus-linked"
QCONFIG_DEFINE="QT_DBUS"

#FIXME: Check if these are still needed with the header package
QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}
include/Qt/
include/QtCore/
include/QtDBus/
src/corelib/global/
src/corelib/io/
src/corelib/kernel/
src/corelib/thread/
src/corelib/tools/
"

src_compile() {
	local myconf
	myconf="${myconf} -dbus-linked"

	qt4-build_src_compile
}
