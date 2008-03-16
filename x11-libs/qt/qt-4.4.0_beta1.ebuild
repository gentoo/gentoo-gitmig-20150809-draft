# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt/qt-4.4.0_beta1.ebuild,v 1.4 2008/03/16 22:28:30 zlin Exp $

EAPI="1"
DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework."
HOMEPAGE="http://www.trolltech.com/"

LICENSE="|| ( QPL-1.0 GPL-3 GPL-2 )"
SLOT="4"
KEYWORDS="~amd64 ~x86"

IUSE="opengl qt3support"

DEPEND="!=x11-libs/qt-4.4.3*:4"
RDEPEND="${DEPEND}
	~x11-libs/qt-gui-${PV}
	~x11-libs/qt-svg-${PV}
	~x11-libs/qt-test-${PV}
	~x11-libs/qt-sql-${PV}
	~x11-libs/qt-svg-${PV}
	~x11-libs/qt-test-${PV}
	~x11-libs/qt-assistant-${PV}
	~x11-libs/qt-xmlpatterns-${PV}
	opengl? ( ~x11-libs/qt-opengl-${PV} )
	qt3support? ( ~x11-libs/qt-qt3support-${PV} )"
