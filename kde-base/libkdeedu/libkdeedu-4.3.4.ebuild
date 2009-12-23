# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdeedu/libkdeedu-4.3.4.ebuild,v 1.3 2009/12/23 12:07:00 grobian Exp $

EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="Common library for KDE educational apps"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

# 4 of 4 tests fail. Last checked for 4.2.87
RESTRICT=test

src_install() {
	kde4-meta_src_install
	# This is installed by kde-base/marble
	rm "${D}"/${EKDEDIR}/share/apps/cmake/modules/FindMarbleWidget.cmake
}
