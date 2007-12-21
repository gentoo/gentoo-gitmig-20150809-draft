# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-dbus/qt-dbus-4.4.0_rc1.ebuild,v 1.4 2007/12/21 19:07:27 caleb Exp $

inherit qt4-build

SRCTYPE="preview-opensource-src"
DESCRIPTION="The DBus module for the Qt toolkit."
HOMEPAGE="http://www.trolltech.com/"

MY_PV=${PV/_rc/-tp}

SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/qt-x11-${SRCTYPE}-${MY_PV}.tar.gz"
S=${WORKDIR}/qt-x11-${SRCTYPE}-${MY_PV}

LICENSE="|| ( QPL-1.0 GPL-2 )"
SLOT="4"
KEYWORDS="~x86"

# depend on gui instead of core.  There's a GUI based viewer that's built, and since it's a desktop
# protocol I don't know if there's value trying to derive it out into a core build
# The library itself, however, only depends on core and xml

RDEPEND="~x11-libs/qt-core-4.4.0_rc1
	>=sys-apps/dbus-1.0.2"

DEPEND="${RDEPEND}"

src_unpack() {
	qt4-build_src_unpack

	skip_qmake_build_patch
	skip_project_generation_patch
	install_binaries_to_buildtree
}

src_compile() {
	local myconf=$(standard_configure_options)

	myconf="${myconf} -qdbus"

	echo ./configure ${myconf}
	./configure ${myconf} || die

	build_directories src/qdbus tools/qdbus/qdbuscpp2xml tools/qdbus/qdbusxml2cpp
}

src_install() {
	install_directories src/qdbus tools/qdbus/qdbuscpp2xml tools/qdbus/qdbusxml2cpp
	fix_library_files
}

pkg_postinst()
{
	qconfig_add_option qdbus
}

pkg_postrm()
{
	qconfig_remove_option qdbus
}
