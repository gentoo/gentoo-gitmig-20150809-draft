# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde/kde-2.0.1-r1.ebuild,v 1.1 2000/12/18 04:51:11 drobbins Exp $

A=""
S=${WORKDIR}
DESCRIPTION="KDE 2.0.1 virtual package -- depends on base KDE packages"
SRC_URI=""
HOMEPAGE="http://www.kde.org/"

RDEPEND="
	=kde-base/kde-i18n-2.0.1
	=kde-base/kdebase-2.0.1
	=kde-base/kdelibs-2.0.1
	=kde-base/kdesupport-2.0.1
	=kde-base/qt-2.2.2
	"
src_install() {
	insinto /etc/env.d
	doins ${FILESDIR}/90kde
}
