# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt/qt-4.4.0_rc1.ebuild,v 1.7 2007/12/21 20:24:16 caleb Exp $

SRCTYPE="preview-opensource-src"
DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework."
HOMEPAGE="http://www.trolltech.com/"

MY_PV=${PV/_rc/-tp}

SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/qt-x11-${SRCTYPE}-${MY_PV}.tar.gz"
S=${WORKDIR}/qt-x11-${SRCTYPE}-${MY_PV}

LICENSE="|| ( QPL-1.0 GPL-2 )"
SLOT="4"
KEYWORDS="~x86"

IUSE="opengl"

RDEPEND="~x11-libs/qt-gui-${PV}
	opengl? ( ~x11-libs/qt-opengl-${PV} )
	~x11-libs/qt-svg-${PV}
	~x11-libs/qt-test-${PV}
	~x11-libs/qt-sql-${PV}
	~x11-libs/qt-svg-${PV}
	~x11-libs/qt-xmlpatterns-${PV}
	~x11-libs/qt-test-${PV}"
