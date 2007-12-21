# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-opengl/qt-opengl-4.4.0_rc1.ebuild,v 1.3 2007/12/21 19:14:31 caleb Exp $

inherit qt4-build

SRCTYPE="preview-opensource-src"
DESCRIPTION="The OpenGL module for the Qt toolkit."
HOMEPAGE="http://www.trolltech.com/"

MY_PV=${PV/_rc/-tp}

SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/qt-x11-${SRCTYPE}-${MY_PV}.tar.gz"
S=${WORKDIR}/qt-x11-${SRCTYPE}-${MY_PV}

LICENSE="|| ( QPL-1.0 GPL-2 )"
SLOT="4"
KEYWORDS="~x86"

IUSE="debug"

RDEPEND="~x11-libs/qt-gui-4.4.0_rc1
	( virtual/opengl virtual/glu )"

DEPEND="${RDEPEND}"

src_unpack() {

	qt4-build_src_unpack

	skip_qmake_build_patch
	skip_project_generation_patch
	install_binaries_to_buildtree
}

src_compile() {
	local myconf=$(standard_configure_options)
	myconf="${myconf} -opengl"

	if built_with_use ~x11-libs/qt-core-${PV} qt3support; then
		myconf="${myconf} -qt3support"
	else
		myconf="${myconf} -no-qt3support"
	fi

	echo ./configure ${myconf}
	./configure ${myconf} || die

	build_directories src/opengl
	# Not building tools/designer/src/plugins/tools/view3d as it's commented out of the build in the source
}

src_install() {
	install_directories src/opengl

	fix_library_files
}

pkg_postinst()
{
	qconfig_add_option opengl
}

pkg_postrm()
{
	qconfig_remove_option opengl
}
