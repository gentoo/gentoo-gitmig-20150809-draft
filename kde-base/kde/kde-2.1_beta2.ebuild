# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-2.1_beta2.ebuild,v 1.1 2001/01/31 20:49:06 achim Exp $

A=""
S=${WORKDIR}
DESCRIPTION="KDE 2.0.1 virtual package -- depends on base KDE packages"
SRC_URI=""
HOMEPAGE="http://www.kde.org/"

RDEPEND="
	=virtual/kde-i18n-${PV}
	=kde-base/kdebase-${PV}
	=kde-base/kdelibs-${PV}
	=kde-base/kdesupport-${PV}
	>=x11-libs/qt-x11-2.2.3
	"
src_install() {

	insinto /etc/env.d
	doins ${FILESDIR}/90kde21
	exeinto /usr/X11R6/bin/wm
	doexe ${FILESDIR}/kde21

}
