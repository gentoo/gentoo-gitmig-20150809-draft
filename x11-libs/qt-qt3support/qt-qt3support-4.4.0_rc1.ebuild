# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-qt3support/qt-qt3support-4.4.0_rc1.ebuild,v 1.12 2008/01/05 00:11:32 caleb Exp $

inherit qt4-build

SRCTYPE="preview-opensource-src"
DESCRIPTION="The Qt3 support module for the Qt toolkit."
HOMEPAGE="http://www.trolltech.com/"

MY_PV=${PV/_rc/-tp}

SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/qt-x11-${SRCTYPE}-${MY_PV}.tar.gz"
S=${WORKDIR}/qt-x11-${SRCTYPE}-${MY_PV}

LICENSE="|| ( QPL-1.0 GPL-2 )"
SLOT="4"
KEYWORDS="~x86"

RDEPEND="~x11-libs/qt-gui-${PV}
	~x11-libs/qt-sql-${PV}"

DEPEND="${RDEPEND}"

QT4_TARGET_DIRECTORIES="src/qt3support tools/designer/src/plugins/widgets tools/qtconfig src/tools/uic3 tools/porting"

pkg_setup() {
	qt4-build_pkg_setup

	if ! built_with_use =x11-libs/qt-core-4* qt3support; then
		eerror "In order for the qt-qt3support package to install, you must set the \"qt3support\" use flag, then"
		eerror "re-emerge the following packages: x11-libs/qt-core, x11-libs/qt-gui, x11-libs/qt-sql."
		die
	fi
}

src_unpack() {
	qt4-build_src_unpack

	skip_qmake_build_patch
	skip_project_generation_patch
	install_binaries_to_buildtree
}

src_compile() {
	local myconf=$(standard_configure_options)

	if built_with_use ~x11-libs/qt-gui-${PV} accessibility; then
		myconf="${myconf} -accessibility"
	else
		myconf="${myconf} -no-accessibility"
	fi

	myconf="${myconf} -qt3support"

	echo ./configure ${myconf}
	./configure ${myconf} || die

	build_target_directories
}

# Don't postinst qt3support into qconfig.pri here, it's handled in qt-core by way of the use flag.
