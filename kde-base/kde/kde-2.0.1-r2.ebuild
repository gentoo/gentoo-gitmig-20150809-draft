# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-2.0.1-r2.ebuild,v 1.3 2001/01/31 20:34:47 achim Exp $

A=""
S=${WORKDIR}
DESCRIPTION="KDE 2.0.1 virtual package -- depends on base KDE packages"
SRC_URI=""
HOMEPAGE="http://www.kde.org/"

RDEPEND="
	=virtual/kde-i18n-2.0.1
	=kde-base/kdebase-2.0.1
	=kde-base/kdelibs-2.0.1
	=kde-base/kdesupport-2.0.1
	>=kde-base/qt-2.2.2
	"
src_install() {

	insinto /etc/env.d
	doins ${FILESDIR}/90kde
	exeinto /usr/X11R6/bin/wm
	doexe ${FILESDIR}/kde2

}
