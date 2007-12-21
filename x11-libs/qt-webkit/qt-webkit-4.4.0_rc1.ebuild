# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-webkit/qt-webkit-4.4.0_rc1.ebuild,v 1.7 2007/12/21 22:38:38 mr_bones_ Exp $

inherit qt4-build

SRCTYPE="preview-opensource-src"
DESCRIPTION="The Webkit module for the Qt toolkit."
HOMEPAGE="http://www.trolltech.com/"

MY_PV=${PV/_rc/-tp}

SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/qt-x11-${SRCTYPE}-${MY_PV}.tar.gz"
S=${WORKDIR}/qt-x11-${SRCTYPE}-${MY_PV}

LICENSE="|| ( QPL-1.0 GPL-2 )"
SLOT="4"
KEYWORDS="~x86"

RDEPEND="~x11-libs/qt-gui-${PV}"

DEPEND="${RDEPEND}"

src_unpack() {
	qt4-build_src_unpack

	skip_qmake_build_patch
	skip_project_generation_patch
	install_binaries_to_buildtree
}

src_compile() {
	local myconf=$(standard_configure_options)

	myconf="${myconf} -webkit"

	echo ./configure ${myconf}
	./configure ${myconf} || die

	build_directories src/3rdparty/webkit/WebCore tools/designer/src/plugins/qwebview
}

src_install() {
	install_directories src/3rdparty/webkit/WebCore tools/designer/src/plugins/qwebview

	fix_library_files
}

pkg_postinst()
{
	qconfig_add_option webkit
}

pkg_postrm()
{
	qconfig_remove_option webkit
}
