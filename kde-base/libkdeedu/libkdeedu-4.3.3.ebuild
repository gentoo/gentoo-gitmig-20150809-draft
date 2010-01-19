# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdeedu/libkdeedu-4.3.3.ebuild,v 1.7 2010/01/19 00:31:32 jer Exp $

EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="Common library for KDE educational apps"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE="debug"

# 4 of 4 tests fail. Last checked for 4.3.3, bug 258857
RESTRICT=test

src_install() {
	kde4-meta_src_install
	# This is installed by kde-base/marble
	rm "${D}"/"${KDEDIR}"/share/apps/cmake/modules/FindMarbleWidget.cmake
}
